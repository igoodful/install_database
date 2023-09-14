







```yaml
kind: ConfigMap
apiVersion: v1
metadata:
  creationTimestamp: 2016-02-18T19:14:38Z
  name: example-config
  namespace: default
data:
  example.property.1: hello
  example.property.2: world
  example.property.file: |-
    property.1=value-1
    property.2=value-2
    property.3=value-3
```



```json

{
    "kind":"ConfigMap",
    "apiVersion":"v1",
    "metadata":{
        "creationTimestamp":"2016-02-18T19:14:38Z",
        "name":"example-config",
        "namespace":"default"
    },
    "data":{
        "example.property.1":"hello",
        "example.property.2":"world",
        "example.property.file":"property.1=value-1\nproperty.2=value-2\nproperty.3=value-3\n"
    }
}





```
