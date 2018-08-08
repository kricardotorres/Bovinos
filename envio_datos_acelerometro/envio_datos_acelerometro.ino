#include <Wire.h>

//libreria envio de datos y modo estacion
#include <ESP8266WiFi.h>
//#include <WiFiClient.h> 

//Direccion I2C de la IMU acelero
 #define MPU  0x68 //0x68;  #define 

// Variables de conexion---------------------------------------------------------
int contconexion = 0;
const char *ssid = "holibebe";
const char *password = "0987654321";

char host[48]; //longitud
String strhost = "desolate-fortress-31830.herokuapp.com"; //ip del equipo o dns 
String strurl = "/api/cow_histories"; // para el post url 
String chipid = ""; //id del equipo no mac
//-----------------------------------------------------------------------------
//Ratios de conversion
#define A_R 16384.0 // 32768/2
#define G_R 131.0 // 32768/250

//Conversion de radianes a grados 180/PI
#define RAD_A_DEG = 57.295779

//MPU-6050 da los valores en enteros de 16 bits
//Valores RAW
int16_t AcX, AcY, AcZ, GyX, GyY, GyZ;

//Angulos
float Acc[2];
float Gy[3];
float Angle[3];

String valores;

long tiempo_prev;
float dt;


String enviardatos(String datos) {
  String linea = "error";
  WiFiClient client;
  strhost.toCharArray(host, 49);
  if (!client.connect(host, 80)) {
    Serial.println("nel intenta otra vez");
    return linea;
  }

  client.print(String("POST ") + strurl + " HTTP/1.1" + "\r\n" + 
               "Host: " + strhost + "\r\n" +
               "Accept: */*" + "*\r\n" +
               "Content-Length: " + datos.length() + "\r\n" +
               "Content-Type: application/x-www-form-urlencoded" + "\r\n" +
               "\r\n" + datos);           
  delay(10);             
  
  Serial.print("llegading");
  // de respuesta 
  unsigned long timeout = millis();
  while (client.available() == 0) {
    if (millis() - timeout > 5000) {
      Serial.println("Cliente fuera de tiempo!");
      client.stop();
      return linea;
    }
  }
  // Lee todas las lineas que recibe del servidro y las imprime por la terminal serial mensaje de confirmacion 
  while(client.available()){
    linea = client.readStringUntil('\r');

    
  }  
  Serial.println(linea);
  return linea;
}

  

void setup()
{
  Wire.begin(4, 5); // D2(GPIO4)=SDA / D1(GPIO5)=SCL
  Wire.beginTransmission(MPU);
  Wire.write(0x6B); //0x6B
  Wire.write(0);
  Wire.endTransmission(true);
  Serial.begin(115200);

 // wifi 
 
  Serial.println("");

  Serial.print("id del chip: "); 
  chipid = String(ESP.getChipId());
  Serial.println(chipid); 
  

  // Conexión WIFI
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED and contconexion <50) { //Cuenta hasta 50 si no se puede conectar lo cancela
    ++contconexion;
    delay(500);
    Serial.print("no conexion");
  }

  // si necesitamos ip fija
  /* if (contconexion <50) {
      //para usar con ip fija
      IPAddress ip(192,168,43,70); // de donde se va guardar 
      IPAddress gateway(192,168,43,255); //
      IPAddress subnet(255,255,255,0); 
      WiFi.config(ip, gateway, subnet); 
      
      Serial.println("");
      Serial.println("WiFi conectado");
      Serial.println(WiFi.localIP());
  }
  else { 
      Serial.println("");
      Serial.println("Error de conexion");
  }*/
}

void loop()
{
  //Leer los valores del Acelerometro de la IMU ejes X Y
  Wire.beginTransmission(MPU);
  Wire.write(0x3B); //Pedir el registro 0x3B - corresponde al AcX
  Wire.endTransmission(false);
  Wire.requestFrom(MPU, 6, true); //A partir del 0x3B, se piden 6 registros
  AcX = Wire.read() << 8 | Wire.read(); //Cada valor ocupa 2 registros
  AcY = Wire.read() << 8 | Wire.read();
  AcZ = Wire.read() << 8 | Wire.read();



  

  //A partir de los valores del acelerometro, se calculan los angulos Y, X
  //respectivamente, con la formula de la tangente.
  Acc[1] = atan(-1 * (AcX / A_R) / sqrt(pow((AcY / A_R), 2) + pow((AcZ / A_R), 2))) * RAD_TO_DEG;
  Acc[0] = atan((AcY / A_R) / sqrt(pow((AcX / A_R), 2) + pow((AcZ / A_R), 2))) * RAD_TO_DEG;



  //Leer los valores del Giroscopio Z
  Wire.beginTransmission(MPU);
  Wire.write(0x43);//0x43
  Wire.endTransmission(false);
  Wire.requestFrom(MPU, 6, true); //A partir del 0x43, se piden 6 registros
  GyX = Wire.read() << 8 | Wire.read(); //Cada valor ocupa 2 registros
  GyY = Wire.read() << 8 | Wire.read();
  GyZ = Wire.read() << 8 | Wire.read();

  //Calculo del angulo del Giroscopio
  Gy[0] = GyX / G_R;
  Gy[1] = GyY / G_R;
  Gy[2] = GyZ / G_R;

  dt = (millis() - tiempo_prev) / 1000.0;
  tiempo_prev = millis();

  //Aplicar el Filtro Complementario
  Angle[0] = 0.98 * (Angle[0] + Gy[0] * dt) + 0.02 * Acc[0];
  Angle[1] = 0.98 * (Angle[1] + Gy[1] * dt) + 0.02 * Acc[1];

  //Integración respecto del tiempo paras calcular el YAW
  Angle[2] = Angle[2] + Gy[2] * dt;

  
//mostrar los valores por consola
   valores = "90, SOY X " + String(Angle[0]) + ", SOY Y:  " + String(Angle[1]) + ", SOY Z:  " + String(Angle[2]) + ", -90";
  Serial.println(valores);


enviardatos("cow_history[x]=" + String(Angle[0]) + "&cow_history[y]=" + String(Angle[1]) +"&cow_history[z]=" + String(Angle[2])+ "&cow_history[cow_id]=1" );

  //pequeño ejemplo enviardatos("chipid=" + chipid + "&temperatura=" + String(temp, 2));

  delay(10);
} 
