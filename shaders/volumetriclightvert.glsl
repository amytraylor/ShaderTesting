 Shader "Custom/FakeVolumetricLightShader" {
 Properties {
     _Fresnel("Fresnel", Range (0., 10.)) = 1.
     _AlphaOffset("Alpha Offset", Range(0., 1.)) = 1.
     _NoiseSpeed("Noise Speed", Range(0., 1.)) = .5
     _Ambient("Ambient", Range(0., 1.)) = .3
     _Intensity("Intensity", Range(0., 1.5)) = .2
     _Fade("Fade", Range(0., 10.)) = 1.
     _Wind("Wind", Range(0., 1.)) = .1
 }
 
 SubShader {
	 // set render type for transparency
	 // transparent will draw after all the opaque geometry drawn 
     Tags {"RenderType" = "Transparent" "Queue" = "Transparent"} 
     LOD 100 // set level of detail minimum
     
     ZWrite Off // we don't need depth buffer, we're gonana use transparency and blending mode
     Blend SrcAlpha One // blend mode - additive with transparency
     
     Pass {  
         CGPROGRAM
             #pragma vertex vert
             #pragma fragment frag

             #include "UnityCG.cginc"
             #include "classicNoise3d.cginc" // import noise functions
 
             struct appdata_t {
                 float4 vertex : POSITION;
                 float3 normal : NORMAL;
                 float2 uv : TEXCOORD0;
             };
 
             struct v2f {
	             float4 vertex : SV_POSITION;
                 float3 worldPos : TEXCOORD1;
                 half2 uv : TEXCOORD0;
                 float3 normal : NORMAL;
             };
 
             float _Fresnel;
             float _AlphaOffset;
             float _NoiseSpeed;
             float _Ambient;
             float _Intensity;
             float _Fade;
             float _Wind;
             
             v2f vert (appdata_t v){
				v2f o;

				// add noise to vertices 
				float noise = _Wind * cnoise(v.normal + _Time.y);
				float4 nv = float4(v.vertex.xyz + noise * v.normal, v.vertex.w);
				// move model's vertices to screen position 
				o.vertex = UnityObjectToClipPos(nv);	
				// get vertex's world position 
				o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz; 
				// get world mormal
				o.normal = UnityObjectToWorldNormal(v.normal);
				o.uv = v.uv;

				return o;
             }
             
             
         ENDCG
		}
	}
}

