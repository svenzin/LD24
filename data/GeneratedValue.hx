package data;

class GeneratedValue 
{

	public function new(average : Float, variability : Float) 
	{
		Average = average;
		Variability = variability;
	}
	
	public function get() : Float
	{
		return Average + (2.0 * Math.random() - 1.0) * Variability;
	}
	
	public function accumulate(value : Float)
	{
		Average = 0.9 * Average + 0.1 * value;
		Variability = 0.5 * Variability + 0.6 * Math.abs(value - Average);
	}

	public var Average : Float;
	public var Variability : Float;
}