#include <iostream>
#include <pcl-1.12/pcl/point_types.h>
#include <stdio.h>

#include "rclcpp/rclcpp.hpp"

int main(int argc, char **argv)
{
	rclcpp::init(argc, argv);

	RCLCPP_INFO(rclcpp::get_logger("ros2pclTest"), "Hello, World");

	rclcpp::shutdown();
	return 0;
}