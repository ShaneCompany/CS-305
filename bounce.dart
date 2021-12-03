import 'dart:html';
import 'dart:math';
import 'dart:async';

//This si based off of the Java Script example given.
//No matter what I tried Dartboard would not compile, even going through the entire dcoumentation
//Even the class examples wouldnt compile, I would still recieve a compile error
CanvasElement canvas = CanvasElement();  
CanvasRenderingContext2D ctx; 


var ball;
//This creates the ball that we will see/play with
class Ball {
  var r = 15.0; 
  var x = 50.0;
  var y = 50.0;
  var vx = 0.0;
  var vy = 0.0;
}

//Funciton to reset the ball when the mouse is clicked
void resetOnClick(MouseEvent event){
  
  
  if(event.offset.x < canvas.width - ball.r && event.offset.y < canvas.height - ball.r){ 
  	ball.x = event.offset.x;
  	ball.y = event.offset.y;
  	ball.vx = 0.0;
  	ball.vy = 0.0;
  }
  
}
//This physically draws the ball so we can actually see it
void drawBall(){
  ctx.clearRect(0,0, canvas.width, canvas.height);
  ctx.fillStyle = "red";
  ctx.fillRect(0, 0, canvas.width, canvas.height);
  ctx.restore();
  
  ball.x = ball.x + ball.vx;
  ball.y = ball.y + ball.vy;
  
  ball.vx = ball.vx * .996;
  ball.vy = ball.vy * .996;
  
  ball.vx = ball.vx + .07; 
  ball.vy = ball.vy + .07; 
  
  ctx.save();
  ctx.translate(ball.x, ball.y);
  ctx.fillStyle = "red"; 
  ctx.beginPath();
  ctx.arc(0, 0, ball.r, 0, pi*2, false);
  ctx.closePath();
  ctx.fill();
  ctx.restore();
  
//The next few lines are to make sure the ball stays in the boundaries
  if (ball.y + ball.r > canvas.height){
    ball.y = canvas.height - ball.r;
    ball.vy = (-1) * ball.vy;
  }
  
  if(ball.x + ball.r > canvas.width){
    ball.x = canvas.width - ball.r;
    ball.vx = (-1) * ball.vx;   
    }
  
  
  
  timeWait();
}
//This function makes sure the ball looks normal while moving
Timer timeWait([int milliseconds]) { 
  const timeout = const Duration(milliseconds: 6);
  const ms = const Duration(milliseconds: 1);
  var duration = milliseconds == null ? timeout : ms * milliseconds;
  return new Timer(duration, drawBall);
}

//Calls the functions to create and play with the ball
void main(){
  ball = new Ball();
  canvas = querySelector('#canvas'); 
  ctx = canvas.getContext('2d'); 
  drawBall(); 
  ctx.canvas.onClick.listen(resetOnClick); 
}
