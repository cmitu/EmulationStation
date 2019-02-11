#pragma once
#ifndef ES_CORE_UTILS_FILE_SYSTEM_UTIL_H
#define ES_CORE_UTILS_FILE_SYSTEM_UTIL_H

#include <list>
#include <string>

#include "utils/Hash.h"


namespace Utils
{
	namespace FileSystem
	{
		typedef std::list<std::string> stringList;
		const size_t IO_READ_BUFFER_SIZE = 512 * 1024;

		stringList  getDirContent      (const std::string& _path, const bool _recursive = false);
		stringList  getPathList        (const std::string& _path);
		std::string getHomePath        ();
		std::string getCWDPath         ();
		std::string getExePath         ();
		std::string getPreferredPath   (const std::string& _path);
		std::string getGenericPath     (const std::string& _path);
		std::string getEscapedPath     (const std::string& _path);
		std::string getCanonicalPath   (const std::string& _path);
		std::string getAbsolutePath    (const std::string& _path, const std::string& _base = getCWDPath());
		std::string getParent          (const std::string& _path);
		std::string getFileName        (const std::string& _path);
		std::string getStem            (const std::string& _path);
		std::string getExtension       (const std::string& _path);
		std::string resolveRelativePath(const std::string& _path, const std::string& _relativeTo, const bool _allowHome);
		std::string createRelativePath (const std::string& _path, const std::string& _relativeTo, const bool _allowHome);
		std::string removeCommonPath   (const std::string& _path, const std::string& _common, bool& _contains);
		std::string resolveSymlink     (const std::string& _path);
		bool        removeFile         (const std::string& _path);
		bool        createDirectory    (const std::string& _path);
		bool        exists             (const std::string& _path);
		bool        isAbsolute         (const std::string& _path);
		bool        isRegularFile      (const std::string& _path);
		bool        isDirectory        (const std::string& _path);
		bool        isSymlink          (const std::string& _path);
		bool        isHidden           (const std::string& _path);
		bool        isEquivalent       (const std::string& _path1, const std::string& _path2);
		std::string getFileDigest      (const std::string& _path, Hash& _hash);
		long        getFileSize        (const std::string& _path);
	} // FileSystem::

} // Utils::

#endif // ES_CORE_UTILS_FILE_SYSTEM_UTIL_H
