package data;

class Genome 
{
	
	public function new(life : GeneratedValue, speed : GeneratedValue, armor : GeneratedValue) 
	{
		m_leftLife  = life.get();
		m_leftSpeed = speed.get();
		m_leftArmor = armor.get();

		m_rightLife  = life.get();
		m_rightSpeed = speed.get();
		m_rightArmor = armor.get();
		
		compute();
	}
	
	private function compute()
	{
		Life  = Math.round((m_leftLife + m_rightLife) / 2);
		Speed = Math.round((m_leftSpeed + m_rightSpeed) / 2);
		Armor = Math.round((m_leftArmor + m_rightArmor) / 2);
	}
	
	private static function randomize(left : Float, right : Float) : Float
	{
		if (Math.random() >= 0.5)
			return left;
		return right;
	}
	
	private static var m_dummyGenerator : GeneratedValue = new GeneratedValue(0, 0);
	public static function cross(left : Genome, right : Genome) : Genome
	{
		var genome : Genome = new Genome(m_dummyGenerator, m_dummyGenerator, m_dummyGenerator);
		
		genome.m_leftLife  = randomize(left.m_leftLife, right.m_leftLife);
		genome.m_leftSpeed = randomize(left.m_leftSpeed, right.m_leftSpeed);
		genome.m_leftArmor = randomize(left.m_leftArmor, right.m_leftArmor);
		
		genome.m_rightLife  = randomize(left.m_rightLife, right.m_rightLife);
		genome.m_rightSpeed = randomize(left.m_rightSpeed, right.m_rightSpeed);
		genome.m_rightArmor = randomize(left.m_rightArmor, right.m_rightArmor);
		
		genome.compute();
		
		return genome;
	}

	public var Life (default, null) : Float;
	public var Speed(default, null) : Float;
	public var Armor(default, null) : Float;
	
	private var m_leftLife  : Float;
	private var m_leftSpeed : Float;
	private var m_leftArmor : Float;

	private var m_rightLife  : Float;
	private var m_rightSpeed : Float;
	private var m_rightArmor : Float;
}