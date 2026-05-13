/**
 * Skin tone analysis utility for LuxeLogic.
 * Samples video feed at specific landmarks and calculates tone/undertone.
 */

export interface SkinToneResult {
  tone: 'Fair' | 'Light' | 'Medium' | 'Tan' | 'Deep';
  undertone: 'Cool' | 'Warm' | 'Neutral';
  hex: string;
}

export function sampleSkinTone(
  video: HTMLVideoElement,
  landmarks: any[]
): SkinToneResult | null {
  const canvas = document.createElement('canvas');
  canvas.width = video.videoWidth;
  canvas.height = video.videoHeight;
  const ctx = canvas.getContext('2d');
  if (!ctx) return null;

  ctx.drawImage(video, 0, 0);

  // Landmarks for sampling
  const sampleIndices = [10, 234, 454]; // Forehead, Left Cheek, Right Cheek
  let totalR = 0, totalG = 0, totalB = 0;

  sampleIndices.forEach(index => {
    const lm = landmarks[index];
    const x = lm.x * video.videoWidth;
    const y = lm.y * video.videoHeight;
    const pixel = ctx.getImageData(x, y, 1, 1).data;
    totalR += pixel[0];
    totalG += pixel[1];
    totalB += pixel[2];
  });

  const avgR = totalR / sampleIndices.length;
  const avgG = totalG / sampleIndices.length;
  const avgB = totalB / sampleIndices.length;

  const hex = rgbToHex(avgR, avgG, avgB);
  const { tone, undertone } = analyzeComplexion(avgR, avgG, avgB);

  return { tone, undertone, hex };
}

function rgbToHex(r: number, g: number, b: number) {
  return "#" + [r, g, b].map(x => {
    const hex = Math.round(x).toString(16);
    return hex.length === 1 ? "0" + hex : hex;
  }).join("");
}

function analyzeComplexion(r: number, g: number, b: number) {
  // Very simplified analysis logic for prototype
  // In reality, use Lab color space conversion
  const brightness = (r * 299 + g * 587 + b * 114) / 1000;
  
  let tone: SkinToneResult['tone'] = 'Medium';
  if (brightness > 200) tone = 'Fair';
  else if (brightness > 160) tone = 'Light';
  else if (brightness > 120) tone = 'Medium';
  else if (brightness > 80) tone = 'Tan';
  else tone = 'Deep';

  // Undertone based on R vs B ratio
  let undertone: SkinToneResult['undertone'] = 'Neutral';
  if (r > b + 20) undertone = 'Warm';
  else if (b > r + 10) undertone = 'Cool';

  return { tone, undertone };
}
