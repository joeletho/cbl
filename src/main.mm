#include <cbl.h>

#import <Foundation/Foundation.h>

// Use for testing functions
const bool TEST_TAILFILE = 1;
const bool TEST_READFILESTREAM = 0;

enum {
    TERMINATE_PROGRAM = 0,
    RUN_TAIL
};

int getCLIArgs() {
    return 0;
}

int main(int argc, char *argv[]) {
    // if (std::strcmp(argv[1], "start") == 0) { // Used to invoke the program

    auto pool = [[NSAutoreleasePool alloc] init];
    auto cb = [[CBLClipboard alloc] init];
    auto fs = [[CBLFileSystem alloc] init];
    CBLTime time;

    bool running = true;
    char *filePath = (char *) ([fs GetFilePath]);

    while (running) {
        if ([cb UpdateClipboardText]) {
            const char *clipboard_text = [cb GetClipboardText];
            if ([fs AppendFileAtPathWithContent:filePath :clipboard_text]) {

                if (TEST_TAILFILE) {
                    [fs TailFile:filePath];
                }
            }

            if (TEST_READFILESTREAM) {
                [fs ReadFileStream:filePath];
            }

        }

        time.Sleep(333);


        //     // TODO: Listen for any args passed to program while the program is running.
        //     switch (getCLIArgs()) {
        //         case TERMINATE_PROGRAM: break;
        //     }
        //
        //
        // }


        // FIXME: Ignore this for now. It probably won't be needed anyway.
        // int key = PollKeyEvent(cb, 400, CBL_KEYCODE_ESC, CBL_KEYCODE_F, CBL_KEYCODE_T);
        // switch (key) {
        //     case CBL_KEYCODE_ESC: running = false;
        //         break;
        //     case CBL_KEYCODE_F:[fs ReadFileStream:filePath];
        //         break;
        //     case CBL_KEYCODE_T:[fs TailFile:filePath];
        //         break;
        // }

    }

    [(NSAutoreleasePool *) pool release];
}
