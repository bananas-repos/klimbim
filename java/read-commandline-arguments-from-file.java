/**
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the COMMON DEVELOPMENT AND DISTRIBUTION LICENSE
 * 
 * You should have received a copy of the
 * COMMON DEVELOPMENT AND DISTRIBUTION LICENSE (CDDL) Version 1.0
 * along with this program.  If not, see http://www.sun.com/cddl/cddl.html
 * 
 * 2018 http://www.bananas-playground.net
 *
 */

/**
 * This is an example how to simulate / read command line arguments from a file
 * It will use a comandline argument to point to the file to read from
 * so some code is kinda duplicate since we need to read the commandline options
 * twice.
 *
 * more about the commandline usage can be found here
 * https://www.tutorialspoint.com/commons_cli/commons_cli_usage_example.htm
 */

import org.apache.commons.cli.*;
import org.codehaus.plexus.util.cli.CommandLineUtils;

public class Main {

    public static void main(String[] args) {
	    // command line options and parser
        Options options = new Options();
        CommandLineParser parser = new DefaultParser();
        CommandLine cmdline;

        // option for the commandline file
        Option commandFile = Option.builder("cf")
            .argName("FILENAME")
            .longOpt("command-file")
            .desc("Provide command line options read from a file")
            .hasArg()
            .build();
        options.addOption(commandFile);
    }

    // this is kinda duplicate but we need the options first
    // and then decide if there are options from a file
    try {
        cmdline = parser.parse(options, args);
    }
    catch (UnrecognizedOptionException e) {
        HelpFormatter formatter = new HelpFormatter();
        formatter.printHelp("example", options);

        System.exit(1);
        return;
    }

    // check if we use a command line file
    if((cmdline != null) && cmdline.hasOption("cf") && (cmdline.getOptionValue("cf") != null && !cmdline.getOptionValue("cf").isEmpty() )) {
        // now read the file and use the given input as the arguments

        String fileContent = null;
        String filePath = cmdline.getOptionValue("cf");

        // check if file exists
        File f = new File(filePath);
        if(f.exists() && !f.isDirectory()) {
            try {
                fileContent = new String ( Files.readAllBytes( Paths.get(filePath) ) );
            }
            catch (IOException e) {
                e.printStackTrace();

                System.exit(1);
            }
        }

        args = CommandLineUtils.translateCommandline(fileContent);

        try {
            cmdline = parser.parse(options, args);
        }
        catch (UnrecognizedOptionException e) {
            HelpFormatter formatter = new HelpFormatter();
            formatter.printHelp("example", options);

            System.exit(1);
            return;
        }

        // do something
    }
    else {
        System.out.println("Please provide a parameter");
    }
}
