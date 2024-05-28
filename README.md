# Reto 5 ST0263

Reto 5 del curso de Tópicos de Telemática, en el cual se implementa un EMR en AWS.

## Pasos para ejecutar el proyecto

Sigue los pasos del PDF del reto 5 para ejecutar el proyecto (`PDF-Laboratorio-EMR.pdf`).

## core-site.xml fix

Para solucionar el problema de la configuración de `core-site.xml` se debe modificar el archivo `core-site.xml` en la carpeta `conf` de Hadoop, y agregar la siguiente configuración:

```xml
<property>
  <name>hadoop.proxyuser.root.groups</name>
  <value>*</value>
</property>
<property>
  <name>hadoop.proxyuser.root.hosts</name>
  <value>*</value>
</property>
```

## Link del video

[Video del reto 5](https://youtu.be/1Q6J9Z9Z9ZQ)

## Pasos del video

En el script `video_steps.sh` se encuentran los pasos realizados en el video.