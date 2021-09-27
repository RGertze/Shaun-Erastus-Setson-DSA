bal openapi -i ./openapi/openapi.yaml

rm ./client/client.bal
mv ./client.bal ./client/client.bal

mv ./openapi_service.bal ./server/openapi_service_temp.bal

rm ./client/types.bal
rm ./server/types.bal
cp ./types.bal ./client/types.bal
cp ./types.bal ./server/types.bal
rm ./types.bal

echo done creating files...