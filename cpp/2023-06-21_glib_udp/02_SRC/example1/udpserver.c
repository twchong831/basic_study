#include <gio/gio.h>
#include <glib.h>
#define BLOCK_SIZE 50000

static gboolean gio_read_socket(GIOChannel *channel, GIOCondition condition, gpointer data)
{
	char buf[BLOCK_SIZE];
	gsize size = 0;
	// GError *error = NULL;

	if (condition & G_IO_HUP)
		return FALSE;
	GIOError error = g_io_channel_read(channel, buf, BLOCK_SIZE, &size);

	switch (error)
	{
	case G_IO_ERROR_NONE:
		g_message("%p-Received message: [%d]", g_thread_self(), size);
		break;
	case G_IO_ERROR_AGAIN:
		g_error(" IO ERROR AGAIN \n");
		return FALSE;
	case G_IO_ERROR_INVAL:
		g_error(" IO ERROR INVAL \n");
		return FALSE;
	case G_IO_ERROR_UNKNOWN:
		g_error(" IO ERROR UNKNOWN \n");
		return FALSE;
	}


	// check input data
	if (size == 32752)
	{
		g_print("HEADER %X %X\n", buf[0], buf[1]);
	}
	else
	{
		g_print("TAIL %X %X\n", buf[size - 2], buf[size - 1]);
	}

	return TRUE;
}

int main(int argc, char **argv)
{
	GSocket *s_udp;
	GError *err = NULL;
	int idIdle = -1, dataI = 0;
	guint16 udp_port = 5003;
	// GSocketAddress * gsockAddr = G_SOCKET_ADDRESS(g_inet_socket_address_new(g_inet_address_new_any(G_SOCKET_FAMILY_IPV4), udp_port));
	GSocketAddress *gsockAddr = G_SOCKET_ADDRESS(g_inet_socket_address_new(g_inet_address_new_from_string("192.168.3.60"), udp_port));
	s_udp = g_socket_new(G_SOCKET_FAMILY_IPV4, G_SOCKET_TYPE_DATAGRAM, G_SOCKET_PROTOCOL_UDP, &err);

	g_assert(err == NULL);

	if (s_udp == NULL)
	{
		g_print("Error");
		return 1;
	}
	if (g_socket_bind(s_udp, gsockAddr, TRUE, NULL) == FALSE)
	{
		g_print("Error bind\n");
		return 1;
	}

	g_assert(err == NULL);

	int fd = g_socket_get_fd(s_udp);
	GIOChannel *channel = g_io_channel_unix_new(fd);
	guint source = g_io_add_watch(channel, G_IO_IN, (GIOFunc)gio_read_socket, &dataI);
	g_io_channel_unref(channel);

	GMainLoop *loop = g_main_loop_new(NULL, FALSE);

	g_main_loop_run(loop);
	g_main_loop_unref(loop);
}
