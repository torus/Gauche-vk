cube: *.cpp *.h *.hpp
	clang++ -std=c++11 -o $@ -g -I. -DVK_USE_PLATFORM_XCB_KHR -DVULKAN_SAMPLES_BASE_DIR=\".\" -I /home/toru/Downloads/VulkanSDK/1.0.39.1/source/glslang *.cpp -L /home/toru/Downloads/VulkanSDK/1.0.39.1/x86_64/lib/glslang -lvulkan -lxcb -lglslang -lSPIRV -lHLSL -lOSDependent -lOGLCompiler -lpthread
