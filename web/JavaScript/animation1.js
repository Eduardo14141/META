$(document).ready(function(){
	$("#signup_btn").click(function(){
		$("#main").animate({left:"22.5%"},400);
		$("#main").animate({left:"30%"},500);
		$("#login").css("visibility","hidden");
		$("#login").animate({left:"25%"},400);

		$("#signup").animate({left:"22.5%"},400);
		$("#signup").animate({left:"30%"},500);
		$("#signup").css("visibility","visible");
	});


	$("#login_btn").click(function(){
		$("#main").animate({left:"77.5%"},400);
		$("#main").animate({left:"70%"},500);
		$("#login").animate({left:"83.5%"},400);
		$("#login").animate({left:"70%"},500);
		$("#login").css("visibility","visible");

		$("#signup").css("visibility","hidden");
		$("#signup").animate({left:"75%"},400);
	});
});

$(".project").hover3d({
  selector: ".project__card",
  shine: true,
});

$(".project").hover3d({

  // selector for element
  selector      : null,

  // Perspective value for 3d space
  perspective   : 1000,

  // Mouse movement sensitivity
  sensitivity   : 20,

  // Default behavior is the element will follow the mouse, look like it facing the mouse
  invert        : false,

  // Add shining layer
  shine       : false,

  // Helper class when mouse hover in the element
  hoverInClass  : "hover-in",

  // Helper class when mouse hover Out the element
  hoverOutClass : "hover-out",

  // Helper class when the mouse is hovering the element
  hoverClass    : "hover-3d"
  
});

$(".movie").hover3d({
	selector: ".movie__card",
	shine: true,
	sensitivity: 20,
});