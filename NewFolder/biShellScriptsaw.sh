#!/bin/sh

echo "================================="
echo "Shell Script Started"
echo "================================="
echo

echo "Argument Passed: $1"
echo

if [ "$1" = "test" ]; then
    echo "Test argument received"
    echo "Test argument received in second print"
    echo "Running in TEST mode"
else
    echo "Other argument received"
    echo "Running in DEFAULT mode"
fi

echo
echo "Generating sample logs..."

i=1
while [ $i -le 20 ]
do
    echo "Processing file $i..."
    i=`expr $i + 1`
done

echo
echo "Copy completed successfully."
echo "Extraction completed successfully."
echo "Validation completed successfully."
echo "BUILD SUCCESSFUL"

echo
echo "================================="
echo "Shell Script Completed"
echo "================================="

exit 0