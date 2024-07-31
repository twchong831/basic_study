# 소스 코드 분석

```c
#include <math.h>
#include <stdio.h>
#include <stdlib.h>

#ifdef __APPLE__
#include <OpenCL/opencl.h>
#else
#include <CL/cl.h>
#endif

#include "pgm.h"

#define PI 3.14159265358979

#define MAX_SOURCE_SIZE (0x100000)

#define AMP(a, b) (sqrt((a) * (a) + (b) * (b)))

cl_device_id device_id = NULL;
cl_context context = NULL;
cl_command_queue queue = NULL;
cl_program program = NULL;

enum Mode { forward = 0, inverse = 1 };

int setWorkSize(size_t *gws, size_t *lws, cl_int x, cl_int y) {
        switch (y) {
        case 1:
                gws[0] = x;
                gws[1] = 1;
                lws[0] = 16;
                lws[1] = 16;
                break;
        default:
                gws[0] = x;
                gws[1] = y;
                lws[0] = 16;
                lws[1] = 16;
                break;
        }

        return 0;
}

int fftCore(cl_mem dst, cl_mem src, cl_mem spin, cl_int m,
            enum Mode direction) {
        cl_int ret;

        cl_int iter;
        cl_uint flag;

        cl_int n = 1 << m;

        cl_event kernelDone;

        cl_kernel brev = NULL;
        cl_kernel bfly = NULL;
        cl_kernel norm = NULL;

        cl_ulong start;
        cl_ulong end;

        brev = clCreateKernel(program, "bitReverse", &ret);
        if (ret != 0) {
                fprintf(stderr, "Can't create kernel. Error: %d\n", ret);
                exit(1);
        }
        bfly = clCreateKernel(program, "butterfly", &ret);
        if (ret != 0) {
                fprintf(stderr, "Can't create kernel. Error: %d\n", ret);
                exit(1);
        }
        norm = clCreateKernel(program, "norm", &ret);
        if (ret != 0) {
                fprintf(stderr, "Can't create kernel. Error: %d\n", ret);
                exit(1);
        }

        size_t gws[2];
        size_t lws[2];

        switch (direction) {
        case forward:
                flag = 0x00000000;
                break;
        case inverse:
                flag = 0x80000000;
                break;
        }

        ret = clSetKernelArg(brev, 0, sizeof(cl_mem), (void *)&dst);
        if (ret != 0) {
                fprintf(stderr, "Can't set kernel argument. Error: %d\n", ret);
                exit(1);
        }
        ret = clSetKernelArg(brev, 1, sizeof(cl_mem), (void *)&src);
        if (ret != 0) {
                fprintf(stderr, "Can't set kernel argument. Error: %d\n", ret);
                exit(1);
        }
        ret = clSetKernelArg(brev, 2, sizeof(cl_int), (void *)&m);
        if (ret != 0) {
                fprintf(stderr, "Can't set kernel argument. Error: %d\n", ret);
                exit(1);
        }
        ret = clSetKernelArg(brev, 3, sizeof(cl_int), (void *)&n);
        if (ret != 0) {
                fprintf(stderr, "Can't set kernel argument. Error: %d\n", ret);
                exit(1);
        }

        ret = clSetKernelArg(bfly, 0, sizeof(cl_mem), (void *)&dst);
        if (ret != 0) {
                fprintf(stderr, "Can't set kernel argument. Error: %d\n", ret);
                exit(1);
        }
        ret = clSetKernelArg(bfly, 1, sizeof(cl_mem), (void *)&spin);
        if (ret != 0) {
                fprintf(stderr, "Can't set kernel argument. Error: %d\n", ret);
                exit(1);
        }
        ret = clSetKernelArg(bfly, 2, sizeof(cl_int), (void *)&m);
        if (ret != 0) {
                fprintf(stderr, "Can't set kernel argument. Error: %d\n", ret);
                exit(1);
        }
        ret = clSetKernelArg(bfly, 3, sizeof(cl_int), (void *)&n);
        if (ret != 0) {
                fprintf(stderr, "Can't set kernel argument. Error: %d\n", ret);
                exit(1);
        }
        ret = clSetKernelArg(bfly, 5, sizeof(cl_uint), (void *)&flag);
        if (ret != 0) {
                fprintf(stderr, "Can't set kernel argument. Error: %d\n", ret);
                exit(1);
        }

        ret = clSetKernelArg(norm, 0, sizeof(cl_mem), (void *)&dst);
        if (ret != 0) {
                fprintf(stderr, "Can't set kernel argument. Error: %d\n", ret);
                exit(1);
        }
        ret = clSetKernelArg(norm, 1, sizeof(cl_int), (void *)&n);
        if (ret != 0) {
                fprintf(stderr, "Can't set kernel argument. Error: %d\n", ret);
                exit(1);
        }

        /* Reverse bit ordering */
        setWorkSize(gws, lws, n, n);
        ret = clEnqueueNDRangeKernel(queue, brev, 2, NULL, gws, lws, 0, NULL,
                                     NULL);
        if (ret != 0) {
                fprintf(stderr, "Can't enqueue kernel. Error: %d\n", ret);
                exit(1);
        }

        /* Perform Butterfly Operations*/
        setWorkSize(gws, lws, n / 2, n);
        printf("m: %d\nn: %d\ngws: [%ld, %ld]\nlws: [%ld, %ld]\n", m, n, gws[0],
               gws[1], lws[0], lws[1]);
        for (iter = 1; iter <= m; iter++) {
                ret = clSetKernelArg(bfly, 4, sizeof(cl_int), (void *)&iter);
                if (ret != 0) {
                        fprintf(stderr,
                                "Can't set kernel argument. Error: %d\n", ret);
                        exit(1);
                }
                ret = clEnqueueNDRangeKernel(queue, bfly, 2, NULL, gws, lws, 0,
                                             NULL, &kernelDone);
                if (ret != 0) {
                        fprintf(stderr, "Can't enqueue kernel. Error: %d\n",
                                ret);
                        exit(1);
                }
          // event 객체가 완료될때까지 host를 대기
          // 1 : number of events
          // kernelDone : event list
                ret = clWaitForEvents(1, &kernelDone);
                if (ret != 0) {
                        fprintf(stderr, "Failed to wait for event. Error: %d\n",
                                ret);
                        exit(1);
                }
          // profiling이 활성화되어 있다면, profiliing 정보를 회신
          // kernelDone : event 객체
          // CL_PROFILING_COMMAND_START : profiling 정보, 이벤트가 실행될때 카운트를 시작(nsec)
          // QUEUED,SUBMIT,END,COMPLETE
          // sizeof : 리턴 받을 profile 정보 변수의 크기
          // start : profile 정보를 리턴 받을 변수
          // NULL : 
                ret = clGetEventProfilingInfo(kernelDone,
                                              CL_PROFILING_COMMAND_START,
                                              sizeof(cl_ulong), &start, NULL);
                if (ret != 0) {
                        fprintf(stderr,
                                "Failed get profiling info. Error: %d\n", ret);
                        exit(1);
                }
          // CL_PROFILING_COMMAND_END : 이벤트가 끝날 경우 카운트 값을 반환
                ret = clGetEventProfilingInfo(kernelDone,
                                              CL_PROFILING_COMMAND_END,
                                              sizeof(cl_ulong), &end, NULL);
                if (ret != 0) {
                        fprintf(stderr,
                                "Failed get profiling info. Error: %d\n", ret);
                        exit(1);
                }
                printf("Butterfly operation: %10.5f [ms]\n",
                       (end - start) / 1000000.0);
        }

        if (direction == inverse) {
                setWorkSize(gws, lws, n, n);
                ret = clEnqueueNDRangeKernel(queue, norm, 2, NULL, gws, lws, 0,
                                             NULL, &kernelDone);
                if (ret != 0) {
                        fprintf(stderr, "Can't enqueue kernel. Error: %d\n",
                                ret);
                        exit(1);
                }
                ret = clWaitForEvents(1, &kernelDone);
                if (ret != 0) {
                        fprintf(stderr, "Failed to wait for event. Error: %d\n",
                                ret);
                        exit(1);
                }
        }

        ret = clReleaseKernel(bfly);
        if (ret != 0) {
                fprintf(stderr, "Can't release kernel. Error: %d\n", ret);
                exit(1);
        }
        ret = clReleaseKernel(brev);
        if (ret != 0) {
                fprintf(stderr, "Can't release kernel. Error: %d\n", ret);
                exit(1);
        }
        ret = clReleaseKernel(norm);
        if (ret != 0) {
                fprintf(stderr, "Can't release kernel. Error: %d\n", ret);
                exit(1);
        }

        return 0;
}

int main() {
        cl_mem xmobj = NULL;	//cl_mem : buffer
        cl_mem rmobj = NULL;
        cl_mem wmobj = NULL;
        cl_kernel sfac = NULL;	//cl_kernel : kernel object
        cl_kernel trns = NULL;
        cl_kernel hpfl = NULL;

		//platform : 
        cl_platform_id platform_id = NULL;	//platform ID

        cl_uint ret_num_devices;			//unsigned int
        cl_uint ret_num_platforms;

        cl_int ret;

        cl_float2 *xm;
        cl_float2 *rm;
        cl_float2 *wm;

        pgm_t ipgm;		// pgm.h : for fast fourier transform
        pgm_t opgm;

        FILE *fp;
        const char fileName[] = "./fft.cl";
        size_t source_size;
        char *source_str;
        cl_int i, j;
        cl_int n;
        cl_int m;

        int r;

        size_t gws[2];
        size_t lws[2];

        /* Load kernel source code */
        fp = fopen(fileName, "r");
        if (!fp) {
                fprintf(stderr, "Failed to load kernel.\n");
                exit(1);
        }
        source_str = (char *)malloc(MAX_SOURCE_SIZE);
        source_size = fread(source_str, 1, MAX_SOURCE_SIZE, fp);
        fclose(fp);

        /* Read image */
        r = readPGM(&ipgm, "lena.pgm");
        if (r < 0) {
                fprintf(stderr, "Wrong input image format. Exiting...\n");
                exit(1);
        }

        n = ipgm.width;
        m = (cl_int)(log((double)n) / log(2.0));
        xm = (cl_float2 *)malloc(n * n * sizeof(cl_float2));
        rm = (cl_float2 *)malloc(n * n * sizeof(cl_float2));
        wm = (cl_float2 *)malloc(n / 2 * sizeof(cl_float2));

        for (i = 0; i < n; i++) 
		{
			for (j = 0; j < n; j++) 
			{
				((float *)xm)[(2 * n * j) + 2 * i + 0] = 
					(float)ipgm.buf[n * j + i];
				((float *)xm)[(2 * n * j) + 2 * i + 1] = (float)0;
			}
        }

        /* Get platform/device  */
        ret = clGetPlatformIDs(1, &platform_id, &ret_num_platforms);	//��� ������ �÷����� �ִ��� Ȯ��
		// 1 : 요청하는 플랫폼의 수
		// platform_id : platform's ID
		// ret_num_platforms : 존재하는 flatfrom의 수
        if (ret != 0) {
                fprintf(stderr, "Can't get platform. Error: %d\n", ret);
                exit(1);
        }
        ret = clGetDeviceIDs(platform_id, CL_DEVICE_TYPE_DEFAULT, 1, &device_id,
                             &ret_num_devices);
		// 계산 디바이스의 ID를 가져옴
		// platform_id : platform의 ID
		// cl_device_type_default : 사용하고자하는 계산 디바이스의 종류
		// CPU : host process, GPU, ACCELERATOR : 가속시
		// ALL : 해당 플랫폼과 관련된 모든 디바이스
		// 1 : 디바이스 포인터 개수
		// device_id : 디바이스 포인터
		// ret_num_devices : 사용 가능한 디바이스 개수
        if (ret != 0) {
                fprintf(stderr, "Can't get device id. Error: %d\n", ret);
                exit(1);
        }

        /* Create OpenCL context */
        context = clCreateContext(NULL, 1, &device_id, NULL, NULL, &ret);
		//context 생성
		// NULL : context에 지원되는 속성들
		// 1 : 디바이스 포인터 개수
		// device_id : 디바이스 포인터
		// NULL : context가 에러를 발생했을 경우 보고하는 콜백 함수
		// NULL : pfn_notify의 마지막 인자
		// ret : error code return

        if (ret != 0) {
                fprintf(stderr, "Can't create context. Error: %d\n", ret);
                exit(1);
        }

        /* Create Command queue */
        queue = clCreateCommandQueue(context, device_id,
                                     CL_QUEUE_PROFILING_ENABLE, &ret);
		//kernel이 각 디바이스별로 실행되기 위해서 스케줄러로서 동작
		// context : 유효한 context 객체
		// device_id : command queue가 실행될 디바이스
		// CL_QUEUE_PROFLING_ENABLE : 속성
		// ret : error code return
        if (ret != 0) {
                fprintf(stderr, "Can't create queue. Error: %d\n", ret);
                exit(1);
        }

        /* Create Buffer Objects */
		// clCreateBuffer		: create buffer
		// clCreateSubBuffer	: create sub-buffer
		// clCreateImage2D		: create 2D image
		// clCreateImage3D		: create 3D image
        xmobj = clCreateBuffer(context, CL_MEM_READ_WRITE,
                               n * n * sizeof(cl_float2), NULL, &ret);
		// context : 버퍼를 할당해주는 유효한 context
		// CL_MEM_READ_WRITE : 커널에서 R/W 수행 명시(default)
		// CL_MEM_WRITE_ONLY/READ_ONLY
		// CL_MEM_USE_HOST_PTR : host ptr이 가리키는 메모리 주소를 그대로 사용
		// CL_MEM_ALLOC_HOST_PTR : 호스트에서 접근가능한 영영에 메모리를 할당하고 그 메모리 주소를 사용, 
                //HOST_PTR과 같이 사용할 수 없음
		// CL_MEM_COPY_HOST_PTR : host ptr이 카리키고 있는 메모리를 opencl에서 할당된 메모리로 복사, 
                //use_host_ptr과는 같이 쓸수 없으며, alloc_host_ptr과는 같이 사용 가능
		// sizeof : 버퍼의 크기
		// NULL : 응용프로그램에서 할당된 메모리 주소
		//ret : error code return

        if (ret != 0) {
                fprintf(stderr, "Can't create buffer. Error: %d\n", ret);
                exit(1);
        }
        rmobj = clCreateBuffer(context, CL_MEM_READ_WRITE,
                               n * n * sizeof(cl_float2), NULL, &ret);
        if (ret != 0) {
                fprintf(stderr, "Can't create buffer. Error: %d\n", ret);
                exit(1);
        }
        wmobj = clCreateBuffer(context, CL_MEM_READ_WRITE,
                               (n / 2) * sizeof(cl_float2), NULL, &ret);
        if (ret != 0) {
                fprintf(stderr, "Can't create buffer. Error: %d\n", ret);
                exit(1);
        }
		//3���� ���۸� ����

        /* Transfer data to memory buffer */
        ret =
            clEnqueueWriteBuffer(queue, xmobj, CL_TRUE, 0,
                                 n * n * sizeof(cl_float2), xm, 0, NULL, NULL);
		// 생성한 버퍼의 포인터와 넣을 값의 포인터를 인자로 쓰기 실행
		// queue : command_queue, 
		// xmobj : buffer object
		// CL_TRUE : write blocking/non-blocking
		// 0 : offset
		// sizof : 쓰는 데이터의 크기
		// xm : host 메모리의 버퍼에 대한 포인터
		// 0 : num_event_in_wait_list
		// NULL : event_wait_list
		// NULL : event
        if (ret != 0) {
                fprintf(stderr, "Can't write buffer. Error: %d\n", ret);
                exit(1);
        }

        /* Create kernel program from source */
        program =
            clCreateProgramWithSource(context, 1, (const char **)&source_str,
                                      (const size_t *)&source_size, &ret);
		// 소스로부터 직접 빌드하는 함수
		// context : program 객체를 생성하는 context
		// 1 : strings 문자열 포인터 개수
		// source_str : 커널들이 담겨있는 소스 문자열들
		// source_size : strings의 각 문자열 포인터들의 길이를 담고 있는 배열
		// ret : return error code
		// .cl를 로드하여 직접 빌드를 실행함...
        if (ret != 0) {
                fprintf(stderr, "Can't create program. Error: %d\n", ret);
                exit(1);
        }

        /* Build kernel program */
        ret = clBuildProgram(program, 1, &device_id, NULL, NULL, NULL);
		// 
        if (ret != 0) {
                fprintf(stderr, "Can't build program. Error: %d\n", ret);
                exit(1);
        }

        /* Create OpenCL Kernel */
		// program이 생성되었다면, API를 이용해 kernel 객체를 생성
		// program : 유효한 프로그램 객체
		// "spinFact" : 프로그램 소스에서 커널 지정자로 시작하는 함수의 이름
		// ret : 에러코드 리턴, NULL이면 패스
  	// 함수들은 .cl 파일, 즉 fft.cl 내에 정의되어 있음
  	// 생성된 커널을 리턴
        sfac = clCreateKernel(program, "spinFact", &ret);
        if (ret != 0) {
                fprintf(stderr, "Can't create kernel. Error: %d\n", ret);
                exit(1);
        }
        trns = clCreateKernel(program, "transpose", &ret);
        if (ret != 0) {
                fprintf(stderr, "Can't create kernel. Error: %d\n", ret);
                exit(1);
        }
        hpfl = clCreateKernel(program, "highPassFilter", &ret);
        if (ret != 0) {
                fprintf(stderr, "Can't create kernel. Error: %d\n", ret);
                exit(1);
        }

        /* Create spin factor */
  			// 커널에 들어갈 변수를 설정
  			// sfac : 커널
  			// 0 : index
  			// sizeof : 버퍼의 크기
  			// wmobj : 버퍼
  			//sfac = void spinFact(__global float2 *w, int n)
        ret = clSetKernelArg(sfac, 0, sizeof(cl_mem), (void *)&wmobj);	//float2 *w
        ret = clSetKernelArg(sfac, 1, sizeof(cl_int), (void *)&n);			//int n
        setWorkSize(gws, lws, n / 2, 1);	//gws, lws 값 세팅
  			// n = image.width
  /* 참조
  int setWorkSize(size_t *gws, size_t *lws, cl_int x, cl_int y) {
        switch (y) {
        case 1:
                gws[0] = x; = image/2 = 512/2 = 256
                gws[1] = 1;
                lws[0] = 16;
                lws[1] = 16;
                break;
        default:
                gws[0] = x;
                gws[1] = y;
                lws[0] = 16;
                lws[1] = 16;
                break;
        }

        return 0;
}
  */
  			// 커널 실행, 
				// queue : command queue
  			// sfac : kernel
  			// 1 : 연산 유닛들이 자리한 grid의 차원, 1차원임을 의미, 다차원이미 그만큼 증가
  			// NULL : 오프셋, 현재 지원 x
  			// gws : 연산 유닛의 사이즈
  			// lws : 연산 유닛의 로컬 그룹별 사이즈
  			// 0 : 커맨드가 실행되기 전의 이벤트 커맨드 개수
  			// NULL : 커맨드가 실행되기 전의 이벤트 커맨드 리스트
  			// NULL : 이벤트 오브젝트
        ret = clEnqueueNDRangeKernel(queue, sfac, 1, NULL, gws, lws, 0, NULL, NULL);
        if (ret != 0) {
                fprintf(stderr, "Can't enqueue kernel. Error: %d\n", ret);
                exit(1);
        }

        /* Butterfly Operation */
        fftCore(rmobj, xmobj, wmobj, m, forward);

        /* Transpose matrix */
        ret = clSetKernelArg(trns, 0, sizeof(cl_mem), (void *)&xmobj);
        ret = clSetKernelArg(trns, 1, sizeof(cl_mem), (void *)&rmobj);
        ret = clSetKernelArg(trns, 2, sizeof(cl_int), (void *)&n);
        setWorkSize(gws, lws, n, n);
        ret = clEnqueueNDRangeKernel(queue, trns, 2, NULL, gws, lws, 0, NULL, NULL);
        if (ret != 0) {
                fprintf(stderr, "Can't enqueue kernel. Error: %d\n", ret);
                exit(1);
        }

        /* Butterfly Operation */
        fftCore(rmobj, xmobj, wmobj, m, forward);

        /* Apply high-pass filter */
        cl_int radius = n / 8;
        ret = clSetKernelArg(hpfl, 0, sizeof(cl_mem), (void *)&rmobj);
        ret = clSetKernelArg(hpfl, 1, sizeof(cl_int), (void *)&n);
        ret = clSetKernelArg(hpfl, 2, sizeof(cl_int), (void *)&radius);
        setWorkSize(gws, lws, n, n);
        ret = clEnqueueNDRangeKernel(queue, hpfl, 2, NULL, gws, lws, 0, NULL,
                                     NULL);
        if (ret != 0) {
                fprintf(stderr, "Can't enqueue kernel. Error: %d\n", ret);
                exit(1);
        }

        /* Inverse FFT */

        /* Butterfly Operation */
        fftCore(xmobj, rmobj, wmobj, m, inverse);

        /* Transpose matrix */
        ret = clSetKernelArg(trns, 0, sizeof(cl_mem), (void *)&rmobj);
        ret = clSetKernelArg(trns, 1, sizeof(cl_mem), (void *)&xmobj);
        setWorkSize(gws, lws, n, n);
        ret = clEnqueueNDRangeKernel(queue, trns, 2, NULL, gws, lws, 0, NULL,
                                     NULL);
        if (ret != 0) {
                fprintf(stderr, "Can't enqueue kernel. Error: %d\n", ret);
                exit(1);
        }

        /* Butterfly Operation */
        fftCore(xmobj, rmobj, wmobj, m, inverse);

        /* Read data from memory buffer */
  			// queue : command queue
  			// xmobj : 읽어낼 메모리 
  			// CL_TRUE : 메모리를 읽는 프로세스가 끝날때까지 함수가 결과를 반환하지 않음
  			//    false : 메모리를 읽는 프로세스가 끝날때까지 ptr을 사용할 수 없음
  			// 0 : 메모리를 읽어들일 오프셋
  			// sizeof : 읽어올 메모리의 크기
  			// xm : 메모리가 복사될 호스트의 데이터가 복사될 호스트의 버퍼
  			// 0 : 커맨드가 실행되기 전의 이벤트 커맨드 개수
  			// NULL : 커맨드가 실행되기 전의 이벤트 커맨드 리스트
  			// NULL : 이벤트 오브젝트
        ret = clEnqueueReadBuffer(queue, xmobj, CL_TRUE, 0,
                                  n * n * sizeof(cl_float2), xm, 0, NULL, NULL);
        if (ret != 0) {
                fprintf(stderr, "Can't enqueue buffer read. Error: %d\n", ret);
                exit(1);
        }

        float *ampd;
        ampd = (float *)malloc(n * n * sizeof(float));
        for (i = 0; i < n; i++) {
                for (j = 0; j < n; j++) {
                        ampd[n * ((i)) + ((j))] =
                            (AMP(((float *)xm)[(2 * n * i) + 2 * j],
                                 ((float *)xm)[(2 * n * i) + 2 * j + 1]));
                }
        }
        opgm.width = n;
        opgm.height = n;
        normalizeF2PGM(&opgm, ampd);
        free(ampd);

        /* Write out image */
        writePGM(&opgm, "output.pgm");

        /* Finalizations*/
        ret = clFlush(queue);	//queue의 모든 커맨드를 디바이스에 전달
        if (ret != 0) {
                fprintf(stderr, "Can't flush queue. Error: %d\n", ret);
                exit(1);
        }
        ret = clFinish(queue);	//GPU에서 처리하도록 명령한 작업이 모두 끝낫음을 보장
  			// 
        if (ret != 0) {
                fprintf(stderr, "Can't finish queue. Error: %d\n", ret);
                exit(1);
        }
        ret = clReleaseKernel(hpfl);	//커널을 해제
        if (ret != 0) {
                fprintf(stderr, "Can't release kernel. Error: %d\n", ret);
                exit(1);
        }
        ret = clReleaseKernel(trns);
        if (ret != 0) {
                fprintf(stderr, "Can't release kernel. Error: %d\n", ret);
                exit(1);
        }
        ret = clReleaseKernel(sfac);
        if (ret != 0) {
                fprintf(stderr, "Can't release kernel. Error: %d\n", ret);
                exit(1);
        }
        ret = clReleaseProgram(program);	//프로그램 해제
        if (ret != 0) {
                fprintf(stderr, "Can't release program. Error: %d\n", ret);
                exit(1);
        }
        ret = clReleaseMemObject(xmobj);	//메모리 버퍼 해제
        if (ret != 0) {
                fprintf(stderr, "Can't release memory object. Error: %d\n",
                        ret);
                exit(1);
        }
        ret = clReleaseMemObject(rmobj);
        if (ret != 0) {
                fprintf(stderr, "Can't release memory object. Error: %d\n",
                        ret);
                exit(1);
        }
        ret = clReleaseMemObject(wmobj);
        if (ret != 0) {
                fprintf(stderr, "Can't release memory object. Error: %d\n",
                        ret);
                exit(1);
        }
        ret = clReleaseCommandQueue(queue);	//command queue 해제
        if (ret != 0) {
                fprintf(stderr, "Can't release queue. Error: %d\n", ret);
                exit(1);
        }
        ret = clReleaseContext(context);		//context 해제
        if (ret != 0) {
                fprintf(stderr, "Can't release context. Error: %d\n", ret);
                exit(1);
        }

        destroyPGM(&ipgm);
        destroyPGM(&opgm);

        free(source_str);
        free(wm);
        free(rm);
        free(xm);

        return 0;
}
```



Float2(x,y)