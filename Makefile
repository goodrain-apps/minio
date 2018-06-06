build:
	docker build -t local/minio .

test:
	docker run -it --rm -p 127.0.0.1:9000:9000  --name minio-test local/minio server /data

test-env:
	docker run -it --rm -p 127.0.0.1:9000:9000  -e "MINIO_ACCESS_KEY=AKIAIOSFODNN7EXAMPLE" -e "MINIO_SECRET_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY" --name minio-test local/minio server /data


