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
		
		public function TestAnchor(testMethod:String=null) 
		{
			super(testMethod);
		}
		
		public function testBasicAnchoring():void {
			var entity:Entity = new Entity(0, 0);
			var anchor:Entity = new Entity(10, 10);
			
			FP.anchorTo(entity, anchor);
			assertTrue("Entity should have same x position as Anchor", entity.x == anchor.x);
			assertTrue("Entity should have same y position as Anchor", entity.y == anchor.y);
			
			anchor.moveBy(5, 5);
			assertTrue("Anchor should have changed x position", entity.x != anchor.x);
			assertTrue("Anchor should have changed y position", entity.y != anchor.y);
			
			FP.anchorTo(entity, anchor);
			assertTrue("Entity should have same x position as Anchor", entity.x == anchor.x);
			assertTrue("Entity should have same y position as Anchor", entity.y == anchor.y);
			
			entity.moveBy(5, 5);
			assertTrue("Entity should have changed x position", entity.x != anchor.x);
			assertTrue("Entity should have changed y position", entity.y != anchor.y);
			
			
			FP.anchorTo(entity, anchor);
			assertTrue("Entity should have same x position as Anchor", entity.x == anchor.x);
			assertTrue("Entity should have same y position as Anchor", entity.y == anchor.y);
		}
		
		public function testAnchoringWithDistance():void {
			var entity:Entity = new Entity(0, 0);
			var anchor:Entity = new Entity(100, 100);
			var maxDistance:Number = 10;
			var entityPrevX:Number = entity.x;
			var entityPrevY:Number = entity.y;
			var prevAngle:Number = FP.angle(entity.x, entity.y, anchor.x, anchor.y);
			
			FP.anchorTo(entity, anchor, maxDistance);
			assertTrue("Entity should have changed x position since beyond max distance", entity.x != entityPrevX);
			assertTrue("Entity should have changed y position since beyond max distance", entity.y != entityPrevY);
			var newDistance:Number = entity.distanceFrom(anchor);
			assertTrue("Entity should be about the max distance away from anchor", isAboutSameNumber(newDistance, maxDistance));
			var newAngle:Number = FP.angle(entity.x, entity.y, anchor.x, anchor.y);
			assertTrue("Entity should be about the same angle away from anchor", isAboutSameNumber(newAngle, prevAngle));
			
			anchor.moveBy(-1, -1);
			entity.moveBy(1, 1);
			entityPrevX = entity.x;
			entityPrevY = entity.y;
			FP.anchorTo(entity, anchor, maxDistance);
			assertTrue("Entity should not have changed x position since within max distance", entity.x == entityPrevX);
			assertTrue("Entity should not have changed y position since within max distance", entity.y == entityPrevY);
		}
		
		public function testAnchorRotation():void {
			var entity:Entity = new Entity(0, 0);
			var anchor:Entity = new Entity(10, 10);
			var prevAngleInDegrees:Number = FP.angle(entity.x, entity.y, anchor.x, anchor.y);
			var prevDistance:Number = entity.distanceFrom(anchor);
			var rotateInDegrees:Number = 180;
			
			FP.rotateAround(entity, anchor, rotateInDegrees);
			var angleChange:Number = Math.abs(prevAngleInDegrees - FP.angle(entity.x, entity.y, anchor.x, anchor.y));
			assertTrue("Entity's angle from anchor should have changed", isAboutSameNumber(angleChange, rotateInDegrees));
			var newDistance:Number = entity.distanceFrom(anchor);
			assertTrue("Entity should be about same distance from anchor", isAboutSameNumber(prevDistance, newDistance));
			
			rotateInDegrees = 1;
			var relativeRotation:Boolean = false;
			prevDistance = entity.distanceFrom(anchor);
			FP.rotateAround(entity, anchor, rotateInDegrees, relativeRotation);
			var newRotation:Number = FP.angle(entity.x, entity.y, anchor.x, anchor.y);
			assertTrue("Entity's angle to anchor should've been set as specified", isAboutSameNumber(rotateInDegrees, newRotation));
			newDistance = entity.distanceFrom(anchor);
			assertTrue("Entity should be about same distance from anchor", isAboutSameNumber(prevDistance, newDistance));
			
		}
		
		private function isAboutSameNumber(num1:Number, num2:Number):Boolean {
			return Math.abs(num1 - num2) < 0.1;
		}
	}

}