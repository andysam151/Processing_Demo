float findDrag(float rotx, float roty, int x, int y, int z, float vel){
  float rA = (x * cos(rotx) + y * sin(rotx)) * (z * cos(roty) + y * sin(roty));
  return vel * vel * rA/4;
}
