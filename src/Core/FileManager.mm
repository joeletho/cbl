#include "FileManager.h"
#import <Foundation/Foundation.h>

namespace PBL {

    FileManager::FileManager() {
        mAutoreleasePool = [[NSAutoreleasePool alloc] init];
    }

    FileManager::~FileManager() {
        [(NSAutoreleasePool *) mAutoreleasePool release];
    }

    const char *FileManager::PathForDirectory(SearchPathDirectory directory, SearchPathDomainMask domainMask) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSArray *URLs = [fileManager URLsForDirectory:(NSSearchPathDirectory) directory
                                            inDomains:(NSSearchPathDomainMask) domainMask];
        if (URLs.count == 0) {
            return NULL;
        }

        NSURL *URL = [URLs objectAtIndex:0];
        NSString *path = URL.path;

        // `fileSystemRepresentation` on an `NSString` gives a path suitable for POSIX APIs
        return path.fileSystemRepresentation;
    }

    const char *FileManager::PathForDirectoryForItemAtPath(SearchPathDirectory directory,
                                                           SearchPathDomainMask domainMask,
                                                           const char *itemPath, bool create) {

        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *nsPath = [fileManager stringWithFileSystemRepresentation:itemPath length:strlen(itemPath)];
        NSURL *itemURL = (nsPath ? [NSURL fileURLWithPath:nsPath] : nil);

        NSURL *URL = [fileManager URLForDirectory:(NSSearchPathDirectory) directory
                                         inDomain:(NSSearchPathDomainMask) domainMask
                                appropriateForURL:itemURL
                                           create:create error:NULL];

        return URL.path.fileSystemRepresentation;
    }
}