/** Processing Sound Library
N ondas sinusoidales están en capas para construir un grupo de frecuencias.
Este método se llama síntesis aditiva. 
Utilice la posición del ratón dentro de la ventana de visualización para desafinar 
la agrupación.
 */

import processing.sound.*;

SinOsc[] ondaSeno; // Arreglo de ondas Sinusoidales
float[] frecuencia; // Arreglo de frecuencias
int numOsciladores = 4; // Numero de osciladores a usar = N

void setup() {  
  size(640, 360);
  background(0);

  ondaSeno = new SinOsc[numOsciladores]; // Inicializa osciladores
  frecuencia = new float[numOsciladores]; // Inicializa arreglo de frecuencia

  for (int i = 0; i < numOsciladores; i++) {
    // Calcula la amplitud de cada oscilador
    float volumenSeno = (1.0 / numOsciladores) / (i + 1);
    // Crea el oscilador
    ondaSeno[i] = new SinOsc(this);
    // Inicia el oscilador
    ondaSeno[i].play();
    // Configura la amplitud de todos los osciladores
    ondaSeno[i].amp(volumenSeno);
  }
}

void draw() {
  //Mapea mouseY de 0 a 1
  float yoffset = map(mouseY, 0, height, 0, 1);
  //Mapea mouseY logarítmicamente de 150 - 1150 para crear un rango de frecuencia base
  float frequency = pow(1000, yoffset) + 150;
  //Mapea mouseX a partir de -0.5 a la 0,5 como un argumento desafinación
  float detune = map(mouseX, 0, width, -0.5, 0.5);

  for (int i = 0; i < numOsciladores; i++) { 
    frecuencia[i] = frequency * (i + 1 * detune);
    // Configura la frecuencia de todos los osciladores
    ondaSeno[i].freq(frecuencia[i]);
  }
}