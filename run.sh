#!/usr/bin/sh

source run_0.sh
cd xml_parse && source run_1.sh
cd ../elastic_build && source run_2.sh && source run_3.sh
cd ../upload_data && source run_4.sh

