boolean collidePointRect(float pointX, float pointY, float x, float y, int xW, int yW) {
  //2d
  if (pointX >= x &&         // right of the left edge AND
      pointX <= x + xW &&    // left of the right edge AND
      pointY >= y &&         // below the top AND
      pointY <= y + yW) {    // above the bottom
          return true;
  }
  return false;
};

boolean collideCircleCircle(float x, float y, int d, float x2, float y2, int d2) {
 //2d
  if(dist(x,y,x2,y2) <= (d/2)+(d2/2) ){
    return true;
  }
  return false;
};


boolean collidePointCircle(float x, float y, float cx, float cy, int d) {
  //2d
  if(dist(x,y,cx,cy) <= d/2 ){
    return true;
  }
  return false;
};

boolean collidePointLine(float px, float py, float x1, float y1, float x2, float y2){
  // get distance from the point to the two ends of the line
  float buffer = 0.1;
  float d1 = dist(px,py, x1,y1);
  float d2 = dist(px,py, x2,y2);
  
  // get the length of the line
  float lineLen = dist(x1,y1, x2,y2);
    
  // if the two distances are equal to the line's length, the point is on the line!
  // note we use the buffer here to give a range, rather than one #
  if (d1+d2 >= lineLen-buffer && d1+d2 <= lineLen+buffer) {
    return true;
  }
  return false;
}

boolean collideLineCircle(float x1, float y1, float x2, float y2, float cx, float cy, int diameter) {
  // is either end INSIDE the circle?
  // if so, return true immediately
  boolean inside1 = collidePointCircle(x1,y1, cx,cy,diameter);
  boolean inside2 = collidePointCircle(x2,y2, cx,cy,diameter);
  if (inside1 || inside2) return true;

  // get length of the line
  float distX = x1 - x2;
  float distY = y1 - y2;
  float len = sqrt( (distX*distX) + (distY*distY) );

  // get dot product of the line and circle
  float dot = ( ((cx-x1)*(x2-x1)) + ((cy-y1)*(y2-y1)) ) / pow(len,2);

  // find the closest point on the line
  float closestX = x1 + (dot * (x2-x1));
  float closestY = y1 + (dot * (y2-y1));

  // is this point actually on the line segment?
  // if so keep going, but if not, return false
  boolean onSegment = this.collidePointLine(closestX,closestY,x1,y1,x2,y2);
  if (!onSegment) return false;

  // draw a debug circle at the closest point on the line

  // get distance to closest point
  distX = closestX - cx;
  distY = closestY - cy;
  float distance = sqrt( (distX*distX) + (distY*distY) );

  if (distance <= diameter/2) {
    return true;
  }
  return false;
}

boolean collidePointPoly(float px, float py, PVector[] vertices) {
  boolean collision = false;

  // go through each of the vertices, plus the next vertex in the list
  int next = 0;
  for (int current=0; current<vertices.length; current++) {

    // get next vertex in list if we've hit the end, wrap around to 0
    next = current+1;
    if (next == vertices.length) next = 0;

    // get the PVectors at our current position this makes our if statement a little cleaner
    PVector vc = vertices[current];    // c for "current"
    PVector vn = vertices[next];       // n for "next"

    // compare position, flip 'collision' variable back and forth
    if (((vc.y > py && vn.y < py) || (vc.y < py && vn.y > py)) &&
         (px < (vn.x-vc.x)*(py-vc.y) / (vn.y-vc.y)+vc.x)) {
            collision = !collision;
    }
  }
  return collision;
}

boolean collideCirclePoly(float cx, float cy, int diameter, PVector[] vertices) {
 
  boolean interior = false;
  // go through each of the vertices, plus the next vertex in the list
  int next = 0;
  for (int current=0; current < vertices.length; current++) {

    // get next vertex in list if we've hit the end, wrap around to 0
    next = current+1;
    if (next == vertices.length) next = 0;

    // get the PVectors at our current position this makes our if statement a little cleaner
    PVector vc = vertices[current];    // c for "current"
    PVector vn = vertices[next];       // n for "next"

    // check for collision between the circle and a line formed between the two vertices
    boolean collision = collideLineCircle(vc.x,vc.y, vn.x,vn.y, cx,cy,diameter);
    if (collision) return true;
  }

  // test if the center of the circle is inside the polygon
  if(interior == true){
    boolean centerInside = collidePointPoly(cx,cy, vertices);
    if (centerInside) return true;
  }

  // otherwise, after all that, return false
  return false;
}
