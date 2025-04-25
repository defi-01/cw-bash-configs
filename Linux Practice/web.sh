#!/bin/bash

ACCESS_LOG="PATH"

function ShowHelp {
    echo "Script description: This script provides information about web-server logs."
    echo "Supported commands:"
    echo "  top ip|url|user-agent [NUMBER OF LINES]                Show top items"
    echo "  req-time <DATETIME>                                    Show the total number of requests DATE/TIME"
    echo "  req-code [CODE]                                        Show the total number of responses"
    echo "  req-type [TYPE]                                        Show the total number of requests"
    echo "  help                                                   Show help message"
    echo "Examples:"
    echo "  $0 top URL 25           # Show top 25 most accessed URLs"
    echo "  $0 req-time '25/Nov'    # Count requests containing the date '25/Nov'"
    echo "  $0 req-code 404         # Count responses with HTTP status code 404"
    echo "  $0 req-type POST        # Count requests of type POST"
    echo "  $0 help                 # Show this help message"
}

COMMAND=$1
TYPE=$2
NUMBER=${3:-10}

case ${COMMAND} in
    top)
        case ${TYPE} in
            ip)
                grep -oP '^[^ ]+' ${ACCESS_LOG} | sort | uniq -c | sort -nr | head -n ${NUMBER}
                ;;
            url)
                grep -oP '"[A-Z]+\s\K\/[^ "]+' ${ACCESS_LOG} | sed 's/\?.*//' | sort | uniq -c | sort -nr | head -n ${NUMBER}
                ;;
            user-agent)
                grep -oP '"[^"]*"$' ${ACCESS_LOG} | sort | uniq -c | sort -nr | head -n ${NUMBER}
                ;;
            *)
                ShowHelp
                exit 1
                ;;
        esac
        ;;
    
    req-time)
        if [[ -z ${TYPE} ]]; then
            ShowHelp
            exit 1
        fi
        grep -c ${TYPE} ${ACCESS_LOG}
        ;;
    
    req-code)
        code=${TYPE:-200}
        if [[ ! ${code} =~ ^[0-9]+$ ]]; then
            ShowHelp
            exit 1
        fi
        grep -c "HTTP/[0-9.]*\" ${code} " ${ACCESS_LOG}
        ;;
    
    req-type)
        request_type=${TYPE:-GET}
        grep -c "${request_type} /" ${ACCESS_LOG}
        ;;
    
    *)
        ShowHelp
        exit 1
        ;;
esac
