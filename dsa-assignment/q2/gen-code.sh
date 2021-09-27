rm -rf ./service_temp
rm -rf ./client_temp
bal grpc --input proto/proto_buffer.proto --mode service --output ./service_temp
bal grpc --input proto/proto_buffer.proto --mode client --output ./client_temp
mv ./service_temp/proto_buffer_pb.bal ./server/proto_buffer_pb.bal
mv ./client_temp/proto_buffer_pb.bal ./client/proto_buffer_pb.bal
rm -rf ./service_temp
rm -rf ./client_temp