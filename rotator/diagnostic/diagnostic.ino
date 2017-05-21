void setup() {
  Serial.begin(19200);
  delay(1000);
  pinMode(4, OUTPUT);
  pinMode(5, INPUT_PULLUP);
  digitalWrite(4, LOW);
}

void loop() {
  delay(500);
  Serial.println(digitalRead(5));

}
