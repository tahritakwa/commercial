### **How to export published reports from JasperServer to generate the Export.zip file** 


#### Step 1 

 Open CMD as administrator

#### Step 2 

 Copie and paste this command : 
```
cd C:\Jaspersoft\jasperreports-server-cp-7.5.0\buildomatic
```

#### Step 3 

Copie and paste this command : 
```
js-export.bat --uris /reports --output-zip C:\Jaspersoft\Export.zip --secret-key="0x6f 0x00 0xf1 0xbd 0x46 0x1f 0x62 0xa1 0x03 0x56 0x13 0xda 0x07 0x00 0x7c 0x10"
```
#### Step 4

After a few momements you will find the exported zip file under 
```
C:\Jaspersoft with the name Export.zip
```

#### Key
```
0x6f 0x00 0xf1 0xbd 0x46 0x1f 0x62 0xa1 0x03 0x56 0x13 0xda 0x07 0x00 0x7c 0x10
```