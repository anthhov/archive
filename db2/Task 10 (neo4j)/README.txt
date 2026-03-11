Работаем в neo4j.com/sandbox

1. Зарегестрироваться в neo4j.com/sandbox

2. Установить демонстрационную БД "Network and IT Management"

3. Посмотреть на метаданные графа (схему):
```
CALL db.schema.visualization()
MATCH (rt:Router) RETURN rt.name
MATCH (rack:Rack) RETURN rack.name
...
```

4. Создать новую стойку (Rack) c несколькими маршрутизаторами (Switch). Связать с датацентром. Вывести результат.
```
MATCH (dc:DataCenter{name:"DC1"})
MERGE (dc)-[:CONTAINS]->(rackNew:Rack{name:"CUSTOM",rack:11,zone:5})
WITH dc,rackNew
MATCH (dc)-[:CONTAINS]->(:Rack{zone:4})-[:HOLDS]->(s:Switch)
MERGE p = (rackNew)-[:HOLDS]->(s)
RETURN dc,p
```

5. Найти суммарный объем оперативной памяти (ram) на стойке (Rack) DC1-RCK-1-10:
```
MATCH (:Rack{name:"DC1-RCK-1-10"})-->(:Machine)-->(t:Type)
RETURN sum(t.ram)
```

6. Найти самую актуальную версию ОС (Os) Ubuntu в датацентре:
```
MATCH (:DataCenter)-->(:Rack)-->(:Machine)-->(:OS)-->(v:Version)<--(:OS{name:"Ubuntu"})
RETURN max(v.name)
```

7. Найти сервисы (Service), которые запущены на сервере (Machine) DC1-RCK-1-1-M-24:
```
MATCH (:Machine{name:"DC1-RCK-1-1-M-24"})-->(s:Service)
RETURN s
```

8. Найти сервисы, имеющие самые длинные цепи версий:
```
MATCH p=(:Service)-[:VERSION]->(:Version)-[:PREVIOUS*]->(:Version) WITH max(length(p)) AS l
MATCH p1=(s:Service)-[:VERSION]->(:Version)-[:PREVIOUS*]->(:Version) WHERE length(p1)=l
RETURN s
```
