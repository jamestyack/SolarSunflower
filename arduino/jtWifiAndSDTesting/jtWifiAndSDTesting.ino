#include <SPI.h>
#include <WiFi.h>
#include <SD.h>

char ssid[] = "";      //  your network SSID (name) 
char pass[] = "";   // your network password



// init Wifi client library
WiFiClient client;

char server[] = "192.168.0.101";
int port = 5000;
int wifiStatus = WL_IDLE_STATUS;

const unsigned long postingInterval = 30*1000;
unsigned long lastPostAttemptTime = 0;
const int LEDPIN = 9;
const int SENSOR_PIN = A0;
boolean wasConnectedOnLastIteration;

// for SD card
const int chipSelect = 4;

void setup() {
  
  Serial.begin(9600);
  pinMode(LEDPIN, OUTPUT); // an led to allow some basic UI
  
  Serial.print("Initializing SD card...");
  pinMode(10, OUTPUT); // default chip select pin must be set to output, even if unused
  if (!SD.begin(chipSelect)) {
    Serial.println("SD Card failed, or not present");
    // don't do anything more:
    return;
  }
  Serial.println("SD Card initialized.");
  
  
  // check WIFI shield present
  if (WiFi.status() == WL_NO_SHIELD) {
    Serial.println("WiFi shield not present");
    while(true); // don't continue
  }
  
  while (wifiStatus != WL_CONNECTED) {
    Serial.print("Attempting to connect to ");
    Serial.println(ssid);
    wifiStatus = WiFi.begin(ssid, pass);
    for (int i=0; i<10; i++) {
      digitalWrite(LEDPIN, LOW);
      delay(500);
      digitalWrite(LEDPIN,HIGH);
      delay(500);
    }
    printWifiStatus();
  }
}
  

void loop() {
  
  // if there's no net connection, but there was one last time
  // through the loop, then stop the client:
  if (!client.connected() && wasConnectedOnLastIteration) {
    Serial.println();
    Serial.println("disconnecting.");
    client.stop();
  }

  // if not connected, and posting inteval has passed since
  // your last connection, then connect again and send data:
  if(!client.connected() && (millis() - lastPostAttemptTime > postingInterval)) {
    
    // get the temperature
    int sensorVal = analogRead(SENSOR_PIN);
    // convert the ADC reading to voltage
    float voltage = (sensorVal/1024.0) * 5.0;
    float tempFloat = (voltage - .5) * 100;
    char tempBuffer[20] = "";
    String temperature = dtostrf(tempFloat, 2, 1, tempBuffer);
    Serial.print("Temp in celcius ");
    Serial.println(temperature);
    
    // get the timestamp for the reading
    long timestampForReading = millis();
    char tempBuffer2[20] = "";
    String timestamp = ltoa(timestampForReading, tempBuffer2, 10);
    
    if (httpPOSTRequest(temperature, timestamp)) {
      // it worked (also check for a 200?)
      Serial.println("logging to success log");
      // log to the 'success' log
    } else {
      // it didn't work
      Serial.println("logging to the replay log");
      File dataFile = SD.open("replays.log", FILE_WRITE);
      if (dataFile) {
        dataFile.println("{\"timestamp\":\"" + timestamp +  "\", \"client\":\"arduino\", \"temperature\":\"" + temperature + "\"}");
        dataFile.close();
        Serial.println("Json sent to replays.log");
        Serial.println("{\"timestamp\":\"" + timestamp +  "\", \"client\":\"arduino\", \"temperature\":\"" + temperature + "\"}");
      } else {
        // error with dataFile
        Serial.println("error opening replays.txt");
      }
    }
    // set the post attempt timestamp
    lastPostAttemptTime = timestampForReading;
  }
  // store the state of the connection for next time through
  // the loop:
  wasConnectedOnLastIteration = client.connected();
}

boolean httpPOSTRequest(String temp, String timestamp) {
  Serial.print("Attempting to connect to ");
  Serial.print(server);
  Serial.print(":");
  Serial.println(port);
  if (client.connect(server, port)) {
    // send the HTTP PUT request:
    String payload = "{\"timestamp\":\"" + timestamp +  "\", \"client\":\"arduino\", \"temperature\":\"" + temp + "\"}";
    client.println("POST /temp HTTP/1.1");
    client.println("Host: 192.168.0.101:5000");
    client.println("Connection: close");
    client.print("Content-Length: ");
    client.println( payload.length()); 
    client.println("Content-Type: application/json");
    client.println();
    client.print(payload);
    client.flush();
    Serial.print("POST data sent at ");
    Serial.println(timestamp);
    return true;
  } 
  else {
    // if you couldn't make a connection:
    Serial.println("Connection failed, disconnecting.");
    client.stop();
    return false;
  }
} 

String getJsonString(String temp, String timestamp) {
   return "{\"timestamp\":\"" + timestamp +  "\", \"client\":\"arduino\", \"temperature\":\"" + temp + "\"}";
}

void printWifiStatus() {
  Serial.print("SSID: ");
  Serial.println(WiFi.SSID());

  // print your WiFi shield's IP address:
  IPAddress ip = WiFi.localIP();
  Serial.print("IP Address of shield: ");
  Serial.println(ip);

  // print the received signal strength:
  long rssi = WiFi.RSSI();
  Serial.print("signal strength (RSSI):");
  Serial.print(rssi);
  Serial.println(" dBm");
}

