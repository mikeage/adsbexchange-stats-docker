# Update -- deprecated. UF includes support for the stats package now

# ADSB Exchange stats for Ultrafeeder

## Building the container

```bash
docker build . -t adsbexchange-stats:v1
```

## Edit your Ultrafeeder config

Replace the tmpfs of /run with a volume, and share it with the new container that you just build above.

```patch
diff --git i/ultrafeeder/docker-compose.yml w/ultrafeeder/docker-compose.yml
index 3e554b5..2555237 100644
--- i/ultrafeeder/docker-compose.yml
+++ w/ultrafeeder/docker-compose.yml
@@ -15,6 +15,13 @@ services:
         tmpfs:
             - /run:exec,size=64M
             - /var/log
+
+    adsbexchange-stats:
+        image: adsbexchange-stats:v1
+        restart: unless-stopped
+        volumes:
+          - ultrafeeder-run:/run
+
     ultrafeeder:
         image: ghcr.io/sdr-enthusiasts/docker-adsb-ultrafeeder
     # Note - if you want to enable telegraf for use with InfluxDB/Prometheus and Grafana,
@@ -107,7 +114,9 @@ services:
             - /opt/ultrafeeder/graphs1090:/var/lib/collectd
             - /proc/diskstats:/proc/diskstats:ro
             - /dev:/dev:ro
+            - ultrafeeder-run:/run
         tmpfs:
-            - /run:exec,size=256M
             - /tmp:size=128M
             - /var/log:size=32M
+volumes:
+  ultrafeeder-run:
```
