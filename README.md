# Coding of Shaders
This repositry is a gathering of different types of shaders that I'm implementing to gain better knowledge in coding in GLSL. I'm using my own template in OpenGL where I create a simple plane or geometry to display the procedural material or lightning model that I create in my shaders.

- [Voronoi Pattern](##Voronoi-Pattern)
- [Mandelbrot](##Mandelbrot-Set)


## Voronoi Pattern 
A Voronoi Diagram is the partitioning of a plane into different regions based on their distance to points in a specific subspace of the plane. We call the set of points for seeds and the number of seeds are set beforehand. We then create cells around the seeds that we call Voronoi Cells and all the points inside the same cell share the property that they are all closer to the seed for that cell than to any other seed on the plane.

I generate random numbers according to the random function given in "The Book of Shaders". My first implementation is using a number of 200 seeds, placed randomly on the plane. The inverted image is generated by starting with white as background and then subtracting color value from the minimum distance points instead of adding.

<img src="img/Voronoi_v1.PNG" width = "400" height = "400"/><img src="img/Voronoi_v1white.PNG" width = "400" height = "400"/>

A further update was added with the possibility to display the seeds as points to get a clearer visualization if needed. Here with a smaller and larger number of generated seeds.

<img src="img/Voronoi_v1Seeds.PNG" width = "400" height = "400"/><img src="img/Voronoi500seeds.PNG" width = "400" height = "400"/>

Implemented the pattern on a sphere and added the Phong local reflection model to the scene.

<center>
<img src="img/voronoi_light.PNG" width = "600" height = "600"/>
</center>

## Mandelbrot Set
The Mandelbrot Set is the set of complex numbers $c$ for which the function $f_c(z)=z^2+c$ does not diverge to infinity when iterated from $z=0$ (source [wikipedia](https://en.wikipedia.org/wiki/Mandelbrot_set)).

By increasing the number of iterations per pixel over time, it is possible to create an animated version of the set as can be seen below.

<center>
<img src="img/mandelbrot.gif" width = "600" height = "500"/>
</center>

The Mandelbrot set is popular for having very artistic looking fractals, the following two images have been created by zooming in on specific areas of the set and changing the background color for the image to the left.

<img src="img/mandelbrot2.JPG" width = "400" height = "400"/><img src="img/mandelbrot3.JPG" width = "400" height = "400"/>
