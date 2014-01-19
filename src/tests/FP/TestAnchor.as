package tests.FP 
{
	import asunit.framework.TestCase;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	
	/**
	 * 
	 * @author Sean Snyder
	 */
	public class TestAnchor extends TestCase 
	{
		
		private var entity:Entity;
		private var anchor:Entity;
		public function TestAnchor(testMethod:String=null) 
		{
			super(testMethod);
		}
		
		public function testBasicAnchoring():void {
			setupEntities();
			
			FP.anchorTo(entity, anchor);
			var hasSamePos:Boolean = entity.x == anchor.x && entity.y == anchor.y;
			assertTrue("Entity should have same position as Anchor", hasSamePos);
		}
		
		public function testAnchorMovingAfterAnchoring():void {
			setupEntities();
			FP.anchorTo(entity, anchor);
			
			anchor.moveBy(5, 5);
			var hasChangedPos:Boolean = entity.x != anchor.x || entity.y != anchor.y;
			assertTrue("Anchor should have changed position", hasChangedPos);
		}
		
		public function testEntityMovingAfterAnchoring():void {
			setupEntities();
			FP.anchorTo(entity, anchor);
			
			entity.moveBy(5, 5);
			var hasChangedPos:Boolean = entity.x != anchor.x || entity.y != anchor.y;
			assertTrue("Entity should have changed position", hasChangedPos);
		}
		
		public function testAnchoringOutsideMaxRange():void {
			setupEntities();
			var maxRange:Number = 10;
			var entityPrevX:Number = entity.x;
			var entityPrevY:Number = entity.y;
			var prevAngle:Number = FP.angle(anchor.x, anchor.y, entity.x, entity.y);
			
			FP.anchorTo(entity, anchor, maxRange);
			var hasChangedPos:Boolean = entity.x != entityPrevX || entity.y != entityPrevY;
			var newDistance:Number = entity.distanceFrom(anchor);
			var newAngle:Number = FP.angle(anchor.x, anchor.y, entity.x, entity.y);
			assertTrue("Entity should have changed position since beyond max range", hasChangedPos);
			assertTrue("Entity should now be within range of anchor", isAboutSameNumber(newDistance, maxRange));
			assertTrue("Entity should be about the same angle from anchor", isAboutSameNumber(newAngle, prevAngle));
		}
		
		public function testAnchoringWithinMaxRange():void {
			setupEntities();
			entity.moveTo(anchor.x, anchor.y);
			var maxRange:Number = 10;
			var entityPrevX:Number = entity.x;
			var entityPrevY:Number = entity.y;
			
			FP.anchorTo(entity, anchor, maxRange);
			var hasSamePos:Boolean = entity.x == entityPrevX && entity.y == entityPrevY;
			assertTrue("Entity should not have changed position since within max range", hasSamePos);
		}
		
		public function testRelativeAnchorRotation():void {
			setupEntities();
			var prevAngleInDegrees:Number = FP.angle(anchor.x, anchor.y, entity.x, entity.y);
			var prevDistance:Number = entity.distanceFrom(anchor);
			var rotateInDegrees:Number = 180;
			
			FP.rotateAround(entity, anchor, rotateInDegrees);
			var angleChange:Number = Math.abs(prevAngleInDegrees - FP.angle(anchor.x, anchor.y, entity.x, entity.y));
			var newDistance:Number = entity.distanceFrom(anchor);
			assertTrue("Entity's angle from anchor should have changed", isAboutSameNumber(angleChange, rotateInDegrees));
			assertTrue("Entity should be about same distance from anchor", isAboutSameNumber(prevDistance, newDistance));
		}
		
		public function testAbsoluteAnchorRotation():void {
			setupEntities();
			var prevDistance:Number = entity.distanceFrom(anchor);
			var rotateInDegrees:Number = 1;
			var usingRelativeRotation:Boolean = false;
			
			FP.rotateAround(entity, anchor, rotateInDegrees, usingRelativeRotation);
			var newRotation:Number = FP.angle(anchor.x, anchor.y, entity.x, entity.y);
			var newDistance = entity.distanceFrom(anchor);
			assertTrue("Entity's angle to anchor should've been set as specified", isAboutSameNumber(rotateInDegrees, newRotation));
			assertTrue("Entity should be about same distance from anchor", isAboutSameNumber(prevDistance, newDistance));
			
		}
		
		private function isAboutSameNumber(num1:Number, num2:Number):Boolean {
			return Math.abs(num1 - num2) < 0.1;
		}
		
		private function setupEntities():void 
		{
			entity = new Entity(0, 0);
			anchor = new Entity(100, 1);
		}
	}

}