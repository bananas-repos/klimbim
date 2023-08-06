/**
 * utf8filenamecheck Check if all the filenames in a fiven folder are UTF-8
 * Copyright (C) 2023  Johannes 'Banana' Keßler
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

/**
 * 2023 Small windows C tool to check if paths in a folder are utf-8 formatted
 * This is the windows version
 */
 
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// https://linux.die.net/man/3/nftw
#define _XOPEN_SOURCE 500
#include <ftw.h>

// https://www.argtable.org
#include <argtable3.h>

// https://github.com/simdutf/simdutf
#include <simdutf8check.h>

/**
 * global arg_xxx structs
 * https://www.argtable.org/
 */
struct arg_lit *verbose, *quiet, *help;
struct arg_file *folderToRead;
struct arg_end *end;
const char *program_version = "1.0";
const char *program_bug_address = "https://://www.bananas-playground.net";

struct cmdArguments {
    int quiet, verbose;
    char *folder_to_read;
};

struct cmdArguments arguments;

/**
 * the callback function for nftw
 * https://linux.die.net/man/3/nftw
 */
static int nftw_callback(const char *fpath, 
						const struct stat *sb,
						int tflag, 
						struct FTW *ftwbuf) {
	if (strcmp(fpath, ".") == 0 || strcmp(fpath, "..") == 0) {
		return 0;
	}
		
	if(tflag == FTW_DNR) {
		if(!arguments.quiet) printf("Can not read %s", fpath);
	}
	
	bool result = validate_utf8_fast(fpath, strlen(fpath));
	if(result) {
		if(!arguments.quiet) printf("%s Valid OK \n", fpath);
	} else {
		printf("%s Valid FAILED \n", fpath);
	}
	
	// continue
	return 0;
}

/**
 * the main stuff
 */
int main(int argc, char *argv[]) {
	
	/**
	 * command line argument default values
	 */
	arguments.quiet = 0;
	arguments.verbose = 0;
	arguments.folder_to_read = ".";
	
	/**
     * https://www.argtable.org/
     */
    void *argtable[] = {
        help = arg_litn(NULL, "help", 0, 1, "Display this help and exit"),
        quiet = arg_litn("q", "quiet", 0, 1, "Display only false ones"),
        verbose = arg_litn("v", "verbose", 0, 1, "Verbose additional output"),
        folderToRead = arg_filen(NULL, NULL, "<folder>", 1, 1, "Folder to read"),
        end = arg_end(20),
    };
    /* argtable parsing */
    int nerrors;
    nerrors = arg_parse(argc,argv,argtable);
    /* special case: '--help' takes precedence over error reporting */
    if (help->count > 0) {
        printf("Usage: utf8check.exe");
        arg_print_syntax(stdout, argtable, "\n");
        arg_print_glossary(stdout, argtable, "  %-25s %s\n");
        arg_freetable(argtable, sizeof(argtable) / sizeof(argtable[0]));
        return(1);
    }
    /* If the parser returned any errors then display them and exit */
    if (nerrors > 0) {
        /* Display the error details contained in the arg_end struct.*/
        arg_print_errors(stdout, end, "utf8check.exe");
        printf("Try '%s --help' for more information.\n", "utf8check.exe");
        arg_freetable(argtable, sizeof(argtable) / sizeof(argtable[0]));
        return(1);
    }
    else {
        arguments.quiet = quiet->count;
        arguments.verbose = verbose->count;
        arguments.folder_to_read = folderToRead->filename[0];
    }

    if(arguments.verbose) {
        printf ("Folder = %s\n"
            "Verbose = %s\n"
			"Quiet = %s\n\n",
            arguments.folder_to_read,
			arguments.verbose ? "yes" : "no",
            arguments.quiet ? "yes" : "no"
        );
    }

	if (nftw(arguments.folder_to_read, nftw_callback, 15, FTW_PHYS)== -1) {
		perror("Reading dir failed");
		exit(EXIT_FAILURE);
	}

	arg_freetable(argtable, sizeof(argtable) / sizeof(argtable[0]));
	exit(EXIT_SUCCESS);
}