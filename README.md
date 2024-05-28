# Reto 5 ST0263

Reto 5 del curso de Tópicos de Telemática, en el cual se implementa un EMR en AWS.

## Introducción

En este laboratorio, vamos a desplegar un clúster EMR en Amazon Web Services. Este es un laboratorio del curso ST0263 – Tópicos Especiales de Telemática. Nuestro objetivo principal es desplegar un clúster de Hadoop utilizando el servicio de AWS EMR para procesar grandes volúmenes de datos.

## Arquitectura de la Solución

![Arquitectura de la Solución](architecture.png)

## ¿Qué es Amazon EMR?

Amazon EMR, o Elastic MapReduce, es un servicio gestionado que facilita la ejecución de frameworks para el procesamiento de grandes volúmenes de datos, tales como Apache Hadoop, Spark, Hive, y más. En esencia, un clúster EMR está compuesto por varias instancias EC2, divididas en un nodo principal y varios nodos de trabajo.

## Objetivo del Laboratorio

En este laboratorio, vamos a desplegar un clúster EMR que constará de un nodo principal y dos nodos de trabajo. Usaremos este clúster para gestionar y procesar datos almacenados en el sistema de archivos HDFS, así como en S3.

## Pasos para Crear el Clúster EMR

### 1. Creación del Bucket S3

Primero, crearemos un bucket S3 que servirá como origen y destino de los datos de entrada y salida. En la consola de AWS, navegamos a S3, creamos un nuevo bucket con un nombre único, y dentro de este bucket, creamos dos carpetas: 'data' y 'logs'.

### 2. Creación de la Llave SSH

Para acceder al clúster, necesitamos una llave SSH. Vamos a EC2, seleccionamos 'Key Pairs', creamos una nueva llave con el nombre 'emr-key.pem' y la descargamos.

### 3. Configuración del Clúster EMR

Ahora, procedemos a configurar el clúster EMR. En la consola de AWS, buscamos EMR y seleccionamos 'Create cluster'. Configuramos el nombre, seleccionamos la versión de EMR, y personalizamos el paquete de aplicaciones incluyendo Hadoop, Hive, Spark, Hue, y otros. Configuramos los grupos de instancias, seleccionamos los tipos de instancia y especificamos la llave SSH creada anteriormente.

### 4. Accediendo al Clúster EMR

Una vez que el clúster esté en estado 'Waiting', modificamos las reglas de seguridad para permitir el acceso SSH. Luego, establecemos una sesión SSH con el nodo principal usando la llave SSH.

### 5. Gestionando el Clúster via Hue

Para gestionar el clúster y las aplicaciones desplegadas, utilizamos Hue. Establecemos un túnel SSH para acceder a Hue desde nuestro navegador web. Creamos una cuenta de administrador en Hue y verificamos la integración con HDFS y S3.

## Verificación de Funcionalidades

Para verificar que todo funciona correctamente, vamos a realizar algunas operaciones en HDFS. Crearemos un directorio, subiremos un archivo, y lo listaremos para confirmar que está presente. También copiaremos datos entre HDFS y S3 para verificar la integración.

### Crear Directorio en HDFS

```sh
sudo -u hdfs hadoop fs -mkdir /user/test
sudo -u hdfs hadoop fs -chown hadoop:hadoop /user/test
```

### Subir Archivo a HDFS

```sh
echo "Hello, EMR!" | hadoop fs -put - /user/test/hello_emr.txt
hadoop fs -ls /user/test
```

### Copiar Datos entre HDFS y S3

```sh
hadoop distcp /user/test/hello_emr.txt s3://tu-bucket-s3/test/hello_emr.txt
hadoop distcp s3://tu-bucket-s3/test/hello_emr.txt /user/test/hello_from_s3.txt
```

### Verificar en la Consola de S3

Vamos a la consola de S3 y verificamos que los archivos se han copiado correctamente.

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

## Conclusión

En conclusión, hemos desplegado un clúster EMR en AWS, configurado las aplicaciones necesarias, y verificado la funcionalidad de procesamiento de datos en HDFS y S3. Este laboratorio demuestra cómo podemos utilizar EMR para manejar grandes volúmenes de datos de manera eficiente. ¡Gracias por su atención!
