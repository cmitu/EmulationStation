#pragma once
#ifndef ES_CORE_IMAGE_IO
#define ES_CORE_IMAGE_IO

#include <stdlib.h>
#include <vector>


class ImageIO
{
public:
	static std::vector<unsigned char> loadFromMemoryRGBA32(const unsigned char * data, const int size, int & width, int & height);
	static void flipPixelsVert(unsigned char* imagePx, const size_t& width, const size_t& height);
	static unsigned char* resizeImage(unsigned char* pixels, const int maxWidth, const int maxHeight);
    static unsigned char* convertImageToPng(unsigned char* pixels, const int width, const int height);
};

#endif // ES_CORE_IMAGE_IO
