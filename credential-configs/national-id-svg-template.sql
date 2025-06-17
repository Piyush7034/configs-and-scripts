INSERT INTO rendering_template (id, template, cr_dtimes, upd_dtimes)
VALUES (gen_random_uuid(), '<svg width="350" height="530" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
  <defs>
    <radialGradient id="gradient" cx="50%" cy="50%" r="50%" fx="50%" fy="50%">
      <stop offset="0%" style="stop-color:#ffffff;stop-opacity:1" />
      <stop offset="100%" style="stop-color:#c1e0e6;stop-opacity:1" />
    </radialGradient>

    <filter id="shadow" x="-50%" y="-50%" width="200%" height="200%">
      <feOffset result="offOut" in="SourceAlpha" dx="0" dy="0" />
      <feGaussianBlur result="blurOut" in="offOut" stdDeviation="1.5" />
      <feBlend in="SourceGraphic" in2="blurOut" mode="normal" />
    </filter>

    <clipPath id="rounded-clip">
     <rect x= "35%" y="0" width="90" height="120" rx="10" ry="10" />
    </clipPath>

    <clipPath id="bg-roundedClip">
      <rect x="0" y="0" width="350" height="530" rx="30" ry="30" />
    </clipPath>

    <style type="text/css">
      @import url(''https://fonts.googleapis.com/css2?family=Inter:wght@400;600&amp;display=swap'');

      .titleSemiBold16 {
        font-family: ''Inter'', sans-serif;
        font-weight: 600;
        font-size: 16px;
        text-anchor: middle;
        fill: #000000;
      }

      .titleSemiBoldMedium {
        font-family: ''Inter'', sans-serif;
        font-weight: 600;
        font-size: 14px;
        text-anchor: middle;
        fill: #000000;
      }

      .titleRegular15 {
        font-family: ''Inter'', sans-serif;
        font-weight: 300;
        font-size: 15px;
        text-anchor: middle;
      }

      .fieldLabelRegular11 {
        font-family: ''Inter'', sans-serif;
        font-weight: 400;
        font-size: 11px;
        text-anchor: start;
        fill: #767676;
      }
      .fieldValueFontRegular11 {
        font-family: ''Inter'', sans-serif;
        font-weight: 600;
        font-size: 11px;
        text-anchor: start;
        fill: #000000;
      }
      .fieldValueFontWrappable {
        font-family: ''Inter'', sans-serif;
        font-weight: 400;
        font-size: 11px;
        text-anchor: start;
        fill: #000000;
        word-wrap: break-word;
      }
      .horizontalLine {
        font-family: ''Inter'', sans-serif;
        font-weight: 600;
        font-size: 11px;
        text-anchor: start;
        fill: #000000;
        font-weight: bold;
        word-wrap: break-word;
      }
    </style>
  </defs>
  <g filter="url(#shadow)">

    <image preserveAspectRatio="xMidYMid slice"
        width="350"
        height="600"
        xlink:href="https://raw.githubusercontent.com/tw-mosip/file-server/master/svg-templates/assets/backdrop.png"
        clip-path="url(#bg-roundedClip)"
         />

    <g transform="translate(0, -10)">
      <image xlink:href="https://raw.githubusercontent.com/tw-mosip/file-server/master/svg-templates/assets/veridonia-logo.png"
              width="70" height="70"
              x="50%" y="15"
              transform="translate(-35, 0)"
              preserveAspectRatio="xMidYMid meet"/>
      <text x="50%" y="95" class="titleSemiBold16">Veridonia National ID
      </text>
      <text x="50%" y="120" class="titleSemiBold16">{{credentialSubject/VID}}
      </text>
    </g>
  <g>

    <g transform="translate(0, 130)">
     <image
        x="35%" y="0"
        width="90" height="120"

        xlink:href="{{credentialSubject/face}}"
        clip-path="url(#rounded-clip)"
        preserveAspectRatio="xMidYMid slice"/>
      <text x="50%" y="145" class="titleSemiBoldMedium">{{credentialSubject/fullName/eng}}
      </text>

      </g>
    </g>

    <g transform="translate(0, 290)">

      <text x="4%" y="15" class="fieldLabelRegular11">Date of Birth
      </text>
      <text x="4%" y="32" class="fieldValueFontRegular11">{{credentialSubject/dateOfBirth}}
      </text>

      <text x="50%" y="15" class="fieldLabelRegular11">Gender
      </text>
      <text x="50%" y="32" class="fieldValueFontRegular11">{{credentialSubject/gender}}
      </text>

    </g>

      <g transform="translate(0, 330)">
      <text x="4%" y="15" class="fieldLabelRegular11">Phone Number
      </text>
      <text x="4%" y="32" class="fieldValueFontRegular11">{{credentialSubject/phone}}
      </text>
        <text x="50%" y="15" class="fieldLabelRegular11" fill="#767676">
          Status
        </text>
        <text x="56%" y="34" class="fieldValueFontRegular11" fill="#000000">
          Valid
        </text>
        <path d="M12,2C6.48,2 2,6.48 2,12s4.48,10 10,10 10,-4.48 10,-10S17.52,2 12,2zM9.29,16.29L5.7,12.7c-0.39,-0.39 -0.39,-1.02 0,-1.41 0.39,-0.39 1.02,-0.39 1.41,0L10,14.17l6.88,-6.88c0.39,-0.39 1.02,-0.39 1.41,0 0.39,0.39 0.39,1.02 0,1.41l-7.59,7.59c-0.38,0.39 -1.02,0.39 -1.41,0z" fill="#239E00" transform="translate(170, 17)" />
    </g>



        <g transform="translate(0, 370)">

      <text x="4%" y="15" class="fieldLabelRegular11">Email
      </text>
      <text x="4%" y="30" class="fieldValueFontRegular11">{{credentialSubject/email}}
      </text>
    </g>
    <g transform="translate(0, 420)">
      <line x1="5%" y1="0" x2="330" y2="0" stroke="#a9a9a9" stroke-width="0.5" />
      <text x="5%" y="20" class="fieldLabelRegular11">Address
      </text>
      <text x="5%" y="25" class="fieldValueFontRegular11">
        <tspan x="15" dy="1.3em">{{fullAddress1}}</tspan>
        <tspan x="15" dy="1.5em">{{fullAddress2}}</tspan>
      </text>
    </g>

    <g transform="translate(0, 500)">
      <line x1="5%" y1="0" x2="330" y2="0" stroke="#a9a9a9" stroke-width="0.5" />
    </g>

  </g>
  <rect x="0" y="0" width="350" height="530" fill="none" filter="url(#shadow)" rx="30" ry="30" stroke="#a9a9a9" stroke-width="0.5" />
</svg>', now(), NULL);