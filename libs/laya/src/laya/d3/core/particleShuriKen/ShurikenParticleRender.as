package laya.d3.core.particleShuriKen {
	import laya.d3.core.Sprite3D;
	import laya.d3.core.Transform3D;
	import laya.d3.core.particleShuriKen.ShuriKenParticle3D;
	import laya.d3.core.particleShuriKen.module.GradientDataNumber;
	import laya.d3.core.particleShuriKen.module.SizeOverLifetime;
	import laya.d3.core.particleShuriKen.module.shape.BaseShape;
	import laya.d3.core.render.BaseRender;
	import laya.d3.math.BoundBox;
	import laya.d3.math.Matrix4x4;
	import laya.d3.math.Quaternion;
	import laya.d3.math.Vector3;
	import laya.d3.resource.models.Mesh;
	import laya.d3.utils.Physics;
	import laya.utils.Stat;
	
	/**
	 * <code>ShurikenParticleRender</code> 类用于创建3D粒子渲染器。
	 */
	public class ShurikenParticleRender extends BaseRender {
		/** @private */
		private var _position:Vector3 = new Vector3();
		/** @private */
		private var _rotation:Quaternion = new Quaternion();
		/** @private */
		private var _scale:Vector3 = new Vector3();
		
		/** @private */
		private var _finalGravity:Vector3 = new Vector3();
		
		/** @private */
		private var _tempRotationMatrix:Matrix4x4 = new Matrix4x4();
		
		/**@private */
		private var _defaultBoundBox:BoundBox;
		
		///**排序模式,无。*/
		//public const SORTINGMODE_NONE:int = 0;
		///**排序模式,通过摄像机距离排序,暂不支持。*/
		//public const SORTINGMODE_BYDISTANCE:int = 1;
		///**排序模式,年长的在前绘制,暂不支持。*/
		//public const SORTINGMODE_OLDESTINFRONT:int = 2;
		///**排序模式,年轻的在前绘制,暂不支持*/
		//public const SORTINGMODE_YOUNGESTINFRONT:int = 3;
		
		/**@private */
		private var _renderMode:int;
		/**@private */
		private var _mesh:Mesh;
		
		/**拉伸广告牌模式摄像机速度缩放,暂不支持。*/
		public var stretchedBillboardCameraSpeedScale:Number;
		/**拉伸广告牌模式速度缩放。*/
		public var stretchedBillboardSpeedScale:Number;
		/**拉伸广告牌模式长度缩放。*/
		public var stretchedBillboardLengthScale:Number;
		
		///**排序模式。*/
		//public var sortingMode:int;
		
		/**
		 * 获取渲染模式。
		 * @return 渲染模式。
		 */
		public function get renderMode():int {
			return _renderMode;
		}
		
		/**
		 * 获取网格渲染模式所使用的Mesh,rendderMode为4时生效。
		 * @return 网格模式所使用Mesh。
		 */
		public function get mesh():Mesh {
			return _mesh
		}
		
		/**
		 * 设置网格渲染模式所使用的Mesh,rendderMode为4时生效。
		 * @param value 网格模式所使用Mesh。
		 */
		public function set mesh(value:Mesh):void {
			if (_mesh !== value) {
				_mesh = value;
				(_owner as ShuriKenParticle3D).particleSystem._initBufferDatas();
			}
		}
		
		/**
		 * 设置渲染模式,0为BILLBOARD、1为STRETCHEDBILLBOARD、2为HORIZONTALBILLBOARD、3为VERTICALBILLBOARD、4为MESH。
		 * @param value 渲染模式。
		 */
		public function set renderMode(value:int):void {
			if (_renderMode !== value) {
				switch (_renderMode) {
				case 0: 
					_removeShaderDefine(ShuriKenParticle3D.SHADERDEFINE_RENDERMODE_BILLBOARD);
					break;
				case 1: 
					_removeShaderDefine(ShuriKenParticle3D.SHADERDEFINE_RENDERMODE_STRETCHEDBILLBOARD);
					break;
				case 2: 
					_removeShaderDefine(ShuriKenParticle3D.SHADERDEFINE_RENDERMODE_HORIZONTALBILLBOARD);
					break;
				case 3: 
					_removeShaderDefine(ShuriKenParticle3D.SHADERDEFINE_RENDERMODE_VERTICALBILLBOARD);
					break;
				case 4: 
					_removeShaderDefine(ShuriKenParticle3D.SHADERDEFINE_RENDERMODE_MESH);
					break;
				}
				_renderMode = value;
				switch (value) {
				case 0: 
					_addShaderDefine(ShuriKenParticle3D.SHADERDEFINE_RENDERMODE_BILLBOARD);
					break;
				case 1: 
					_addShaderDefine(ShuriKenParticle3D.SHADERDEFINE_RENDERMODE_STRETCHEDBILLBOARD);
					break;
				case 2: 
					_addShaderDefine(ShuriKenParticle3D.SHADERDEFINE_RENDERMODE_HORIZONTALBILLBOARD);
					break;
				case 3: 
					_addShaderDefine(ShuriKenParticle3D.SHADERDEFINE_RENDERMODE_VERTICALBILLBOARD);
					break;
				case 4: 
					_addShaderDefine(ShuriKenParticle3D.SHADERDEFINE_RENDERMODE_MESH);
					break;
				default: 
					throw new Error("ShurikenParticleRender: unknown renderMode Value.");
				}
				(_owner as ShuriKenParticle3D).particleSystem._initBufferDatas();
			}
		}
		
		/**
		 * 创建一个 <code>ShurikenParticleRender</code> 实例。
		 */
		public function ShurikenParticleRender(owner:ShuriKenParticle3D) {
			/*[DISABLE-ADD-VARIABLE-DEFAULT-VALUE]*/
			super(owner);
			_defaultBoundBox = new BoundBox(new Vector3(), new Vector3());
			_renderMode = -1;
			stretchedBillboardCameraSpeedScale = 0.0;
			stretchedBillboardSpeedScale = 0.0;
			stretchedBillboardLengthScale = 1.0;
			//sortingMode = SORTINGMODE_NONE;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function _calculateBoundingBox():void {
			//var particleSystem:ShurikenParticleSystem = (_owner as ShuriKenParticle3D).particleSystem;
			//particleSystem._generateBoundingBox();
			//var rotation:Quaternion = _owner.transform.rotation;
			//var corners:Vector.<Vector3> = particleSystem._boundingBoxCorners;
			//for (var i:int = 0; i < 8; i++)
			//	Vector3.transformQuat(corners[i], rotation, _tempBoudingBoxCorners[i]);
			//BoundBox.createfromPoints(_tempBoudingBoxCorners, _boundingBox);
			
			var minE:Float32Array = _boundingBox.min.elements;
			minE[0] = -Number.MAX_VALUE;
			minE[1] = -Number.MAX_VALUE;
			minE[2] = -Number.MAX_VALUE;
			var maxE:Float32Array = _boundingBox.min.elements;
			maxE[0] = Number.MAX_VALUE;
			maxE[1] = Number.MAX_VALUE;
			maxE[2] = Number.MAX_VALUE;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function _calculateBoundingSphere():void {//TODO:更具粒子参数计算
			var centerE:Float32Array = _boundingSphere.center.elements;
			centerE[0] = 0;
			centerE[1] = 0;
			centerE[2] = 0;
			_boundingSphere.radius = Number.MAX_VALUE;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function _renderUpdate(projectionView:Matrix4x4):void {
			var particleSystem:ShurikenParticleSystem = (_owner as ShuriKenParticle3D).particleSystem;
			var transform:Transform3D = _owner.transform;
			transform.worldMatrix.decomposeTransRotScale(_position, _rotation, _scale);
			
			switch (particleSystem.simulationSpace) {
			case 0: //World
				_setShaderValueColor(ShuriKenParticle3D.WORLDPOSITION, Vector3.ZERO);//TODO:是否可不传
				break;
			case 1: //Local
				_setShaderValueColor(ShuriKenParticle3D.WORLDPOSITION, _position);
				break;
			default: 
				throw new Error("ShurikenParticleMaterial: SimulationSpace value is invalid.");
			}
			
			Matrix4x4.createFromQuaternion(_rotation, _tempRotationMatrix);
			_setShaderValueMatrix4x4(ShuriKenParticle3D.WORLDROTATIONMATRIX, _tempRotationMatrix);
			
			switch (particleSystem.scaleMode) {
			case 0: 
				_setShaderValueColor(ShuriKenParticle3D.POSITIONSCALE, _scale);
				_setShaderValueColor(ShuriKenParticle3D.SIZESCALE, _scale);
				break;
			case 1: 
				var localScale:Vector3 = transform.localScale;
				_setShaderValueColor(ShuriKenParticle3D.POSITIONSCALE, localScale);
				_setShaderValueColor(ShuriKenParticle3D.SIZESCALE, localScale);
				break;
			case 2: 
				_setShaderValueColor(ShuriKenParticle3D.POSITIONSCALE, _scale);
				_setShaderValueColor(ShuriKenParticle3D.SIZESCALE, Vector3.ONE);
				break;
			}
			
			var finalGravityE:Float32Array = _finalGravity.elements;
			var gravityE:Float32Array = Physics.gravity.elements;
			var gravityModifier:Number = particleSystem.gravityModifier;
			finalGravityE[0] = gravityE[0] * gravityModifier;
			finalGravityE[1] = gravityE[1] * gravityModifier;
			finalGravityE[2] = gravityE[2] * gravityModifier;
			
			_setShaderValueBuffer(ShuriKenParticle3D.GRAVITY, finalGravityE);
			_setShaderValueInt(ShuriKenParticle3D.SIMULATIONSPACE, particleSystem.simulationSpace);
			_setShaderValueBool(ShuriKenParticle3D.THREEDSTARTROTATION, particleSystem.threeDStartRotation);
			_setShaderValueInt(ShuriKenParticle3D.SCALINGMODE, particleSystem.scaleMode);
			_setShaderValueInt(ShuriKenParticle3D.STRETCHEDBILLBOARDLENGTHSCALE, stretchedBillboardLengthScale);
			_setShaderValueInt(ShuriKenParticle3D.STRETCHEDBILLBOARDSPEEDSCALE, stretchedBillboardSpeedScale);
			_setShaderValueNumber(ShuriKenParticle3D.CURRENTTIME, particleSystem.currentTime);
			
			if (Laya3D.debugMode)
				_renderRenderableBoundBox();
		}
		
		/**
		 * @inheritDoc
		 */
		override public function get boundingBox():BoundBox {
			if (!(_owner as ShuriKenParticle3D).particleSystem.isAlive) {
				return _defaultBoundBox;
			} else {
				if (_boundingBoxNeedChange) {
					_calculateBoundingBox();
					_boundingBoxNeedChange = false;
				}
				return _boundingBox;
			}
		}
	
	}

}