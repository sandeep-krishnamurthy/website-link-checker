#! /bin/sh

cat blc_output.txt | uniq | grep -Eo "(http|https).* " | sort| uniq > unique_current_urls.txt

# Get the older urls from S3 bucket.
aws s3 cp s3://url-link-checker/url_list.txt old_url_list.txt

cat old_url_list.txt unique_current_urls.txt | sort | uniq > new_url_list.txt
regression=false
while IFS= read -r line
do
	err=$(curl -Is $line | head -n 1 | grep 404)
	if [ "$err" ]; then
		if [ "$regression" = false ] ; then
			echo "FAIL: REGRESSION"
			regression=true
		fi
		echo "BROKEN $line $err"
	fi
	unset err
done < new_url_list.txt
aws s3 cp new_url_list.txt s3://url-link-checker/new_url_list.txt
if [ $regression ]; then
	echo "FAIL"
else 
	echo "SUCCESS"
fi
