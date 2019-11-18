fixed4 frag (v2f i) : SV_Target{
				float nu = (i.uv.x < .5)? i.uv.x : (1. - i.uv.x);
				nu = pow(nu, 2.);
				float2 n_uv = float2(nu, i.uv.y);

				float n_a = cnoise(float3(n_uv * 5., 1.) + _Time.y * _NoiseSpeed * -1.) * _Intensity + _Ambient; 
				float n_b = cnoise(float3(n_uv * 10., 1.) + _Time.y * _NoiseSpeed * -1.) * .9; 
				float n_c = cnoise(float3(n_uv * 20., 1.) + _Time.y * _NoiseSpeed * -2.) * .9; 
				float n_d = pow(cnoise(float3(n_uv * 30., 1.) + _Time.y * _NoiseSpeed * -2.), 2.) * .9; 
				float noise = n_a + n_b + n_c + n_d;
				noise = (noise < 0.)? 0. : noise;
				float4 col = float4(noise, noise, noise, 1.);

                 // get vertices directions toward world camera
                 // *note that UnityWorldSpaceViewDir return vertices' direction (not cam's direction)
                 // - float3 WorldSpaceViewDir (float4 v)	
                 // - Returns world space direction (not normalized) from given object space vertex position 
                 // - towards the camera.
                 // - https://docs.unity3d.com/Manual/SL-BuiltinFunctions.html
				 half3 viewDir = normalize(UnityWorldSpaceViewDir(i.worldPos));
				 // get raycast between vertice's dir and normal
				 // discard vertices facing opposite way with view direction 
				 // if the value is closer to 1 then that means the vertex is facing more towards the camera
                 float raycast = saturate(dot(viewDir, i.normal));
                 // make extreme distribution
                 float fresnel = pow(raycast, _Fresnel);

                 // fade out
				 float fade = saturate(pow(1. - i.uv.y, _Fade));

			     col.a *= fresnel * _AlphaOffset * fade;

                 return col;
             }