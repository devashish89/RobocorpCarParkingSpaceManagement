*** Settings ***
Documentation    Car Parking Space Management
Library    RPA.HTTP
Library    OperatingSystem
Library    RPA.FileSystem
Library    ParseJson.py


*** Variables ***
${base_url}=    http://35.233.123.8
${filename}=    car-parking3.jpg
#car-parking3.jpg
#car-parking1.jpg
${max_cars_parked}=    6

*** Tasks ***
Cars Identification
    RPA.FileSystem.Create Directory  ${CURDIR}${/}Output  exist_ok=True
    RPA.FileSystem.Copy File  ${CURDIR}${/}${filename}  ${CURDIR}${/}Output${/}${filename}
    ${file_content}=    Get Binary File  ${CURDIR}${/}${filename}
    &{dic}=    Create Dictionary  image=${file_content}
    LOG  ${dic}
    Create Session  mysession  ${base_url}
    ${response}=    Post Request  mysession  /neurolabs/zia-vision/zia-vision-deployment/20210521.1/zia-vision-endpoint  files=${dic}
    LOG  ${response.status_code}
    ${status_code_str}=    Convert To String  ${response.status_code}
    Should Be Equal  ${status_code_str}  200
    LOG  ${response.content}
    ${cars_parked}=    Bounding Box Object  ${CURDIR}${/}Output${/}${filename}  ${response.content}
    ${avilable_car_parking}=    Evaluate  ${max_cars_parked}-${cars_parked}
    LOG  ${avilable_car_parking}
