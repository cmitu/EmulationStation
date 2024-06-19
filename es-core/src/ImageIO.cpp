#include "ImageIO.h"
#include "Log.h"


#ifndef STB_IMAGE_RESIZE_IMPLEMENTATION
#define STB_IMAGE_RESIZE_IMPLEMENTATION
#include <stb/stb_image_resize2.h>
#endif

#ifndef STB_IMAGE_IMPLEMENTATION
#define STB_IMAGE_IMPLEMENTATION
#define STBI_NO_STDIO
#include <stb/stb_image.h>
#endif

#ifndef STB_IMAGE_WRITE_IMPLEMENTATION
#define STB_IMAGE_WRITE_IMPLEMENTATION
#include <stb/stb_image_write.h>
#endif

std::vector<unsigned char> ImageIO::loadFromMemoryRGBA32(const unsigned char * data, const int size, int & width, int & height)
{
	std::vector<unsigned char> rawData;

	// We can read the pixels already flipped, so we don't need to call 'flipPixelsVert'
	stbi_set_flip_vertically_on_load(true);
	unsigned char *tempData = (unsigned char*)stbi_load_from_memory(data, size, &width, &height, 0, STBI_rgb_alpha);
	if (height > 0 && width > 0) {
		rawData =  std::vector<unsigned char>(tempData, tempData + width * height * 4);
	}
	return rawData;
}

void ImageIO::flipPixelsVert(unsigned char* imagePx, const size_t& width, const size_t& height)
{
	unsigned int temp;
	unsigned int* arr = (unsigned int*)imagePx;
	for(size_t y = 0; y < height / 2; y++)
	{
		for(size_t x = 0; x < width; x++)
		{
			temp = arr[x + (y * width)];
			arr[x + (y * width)] = arr[x + (height * width) - ((y + 1) * width)];
			arr[x + (height * width) - ((y + 1) * width)] = temp;
		}
	}
}

//you can pass 0 for width or height to keep aspect ratio
unsigned char* ImageIO::resizeImage(unsigned char *data, int maxWidth, int maxHeight)
{
	int height = 0;
	int width = 0;

	if (maxWidth == 0 && maxHeight == 0)
		return nullptr;

	unsigned char *in_pixels = stbi_load_from_memory(data, 0, &width, &height, 0, STBI_rgb_alpha);

	if (!in_pixels)
		return nullptr;

	if (maxWidth == 0)
	{
		maxWidth = (int)((maxHeight / height) * width);
	}
	else if (maxHeight == 0)
	{
		maxHeight = (int)((maxWidth / width) * height);
	}

	unsigned char *out_pixels = (unsigned char*)malloc(maxHeight * maxHeight * 4);
	stbir_resize_uint8_linear(in_pixels, width, height, 0, out_pixels, maxWidth, maxHeight, 4, STBIR_4CHANNEL);
	
	if (!out_pixels)
		return nullptr;

	return out_pixels;
}

unsigned char* ImageIO::convertImageToPng(unsigned char* pixels, const int width, const int height)
{
	int length;
	unsigned char* pngData = stbi_write_png_to_mem(pixels, 0, width, height, STBI_rgb_alpha, &length);
	return pngData;
}
