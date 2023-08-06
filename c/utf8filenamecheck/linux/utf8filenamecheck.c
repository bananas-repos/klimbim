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
 * 2023 Small linux C tool to check if paths in a folder are utf-8 formatted
 * Linux version
 */
// https://linux.die.net/man/3/nftw
#define _XOPEN_SOURCE 500
#include <ftw.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <argp.h>

// https://github.com/simdutf/simdutf
#include <simdutf8check.h>

/**
 * Commandline arguments
 * see: https://www.gnu.org/software/libc/manual/html_node/Argp-Example-3.html#Argp-Example-3
 */
const char *argp_program_version = "1.0";
const char *argp_program_bug_address = "https://www.bananas-playground.net/";
static char doc[] = "utf8filenamecheck. Small linux C tool to check if paths in a folder are utf-8 formatted.";
static char args_doc[] = "folder";

/* The options we understand. */
static struct argp_option options[] = {
    {"verbose",'v', 0, 0, "Produce verbose output" },
    {"quiet",'q', 0, 0, "Produce verbose output" },
    { 0 }
};

struct cmdArguments {
    char *args[1];
    int verbose, quiet;
};

/* Parse a single option. */
static error_t
parse_opt (int key, char *arg, struct argp_state *state) {
    struct cmdArguments *arguments = state->input;

    switch (key) {
        case 'v':
            arguments->verbose = 1;
        break;
        case 'q':
            arguments->quiet = 1;
        break;

        case ARGP_KEY_ARG:
          if (state->arg_num >= 1)
            // Too many arguments.
            argp_usage (state);

          arguments->args[state->arg_num] = arg;
        break;

        case ARGP_KEY_END:
          if (state->arg_num < 1)
            /* Not enough arguments. */
            argp_usage (state);
        break;

        default:
        return ARGP_ERR_UNKNOWN;
    }

    return 0;
}

static struct argp argp = { options, parse_opt, args_doc, doc };
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
        if(!arguments.quiet) printf("%s OK \n", fpath);
    } else {
        printf("%s FAILED \n", fpath);
    }
    
    // continue
    return 0;
}

/**
 * main routine
 */
int main(int argc, char *argv[]) {

    /**
     * command line argument parsing and default values
     */
    arguments.verbose = 0;
    arguments.quiet = 0;

    argp_parse (&argp, argc, argv, 0, 0, &arguments);

    if(arguments.verbose) {
        printf ("Folder = %s\n"
            "Verbose = %s\n"
            "Quiet = %s\n",
            arguments.args[0],
            arguments.verbose ? "yes" : "no",
            arguments.quiet ? "yes" : "no"
        );
    }

    if (nftw(arguments.args[0], nftw_callback, 15, FTW_PHYS)== -1) {
        perror("Reading dir failed");
        exit(EXIT_FAILURE);
    }

    exit(EXIT_SUCCESS);
}