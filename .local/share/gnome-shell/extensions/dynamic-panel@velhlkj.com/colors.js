import Gio from "gi://Gio";
import GdkPixbuf from "gi://GdkPixbuf";
export default class Colors {
    static rgbToHsl(r, g, b) {
        r /= 255, g /= 255, b /= 255;
        let max = Math.max(r, g, b), min = Math.min(r, g, b);
        let h, s, l = (max + min) / 2;

        if (max == min) {
            h = s = 0; // achromatic
        } else {
            let d = max - min;
            s = l > 0
            .5 ? d / (2 - max - min) : d / (max + min);
            switch (max) {
                case r: h = (g - b) / d + (g < b ? 6 : 0); break;
                case g: h = (b - r) / d + 2; break;
                case b: h = (r - g) / d + 4; break;
            }
            h /= 6;
        }

        return [Math.round(h * 360), Math.round(s * 100), Math.round(l * 100)];
    }
    static hslToRgb(h, s, l) {
        // 確保 hsl 值在有效範圍內
        h = Math.max(0, Math.min(360, h));
        s = Math.max(0, Math.min(100, s));
        l = Math.max(0, Math.min(100, l));

        // 将 hsl 值转换为 0-1 范围
        h /= 360;
        s /= 100;
        l /= 100;

        let r, g, b;

        if (s === 0) {
            r = g = b = l; // achromatic
        } else {
            const hue2rgb = (p, q, t) => {
                if (t < 0) t += 1;
                if (t > 1) t -= 1;
                if (t < 1 / 6) return p + (q - p) * 6 * t;
                if (t < 1 / 2) return q;
                if (t < 2 / 3) return p + (q - p) * (2 / 3 - t) * 6;
                return p;
            };

            const q = l < 0.5 ? l * (1 + s) : l + s - l * s;
            const p = 2 * l - q;
            r = hue2rgb(p, q, h + 1 / 3);
            g = hue2rgb(p, q, h);
            b = hue2rgb(p, q, h - 1 / 3);
        }

        return [Math.round(r * 255), Math.round(g * 255), Math.round(b * 255)];
    }
    static getCustomColor(settings) {
        let D_BGC = settings.get_string('dark-bg-color');
        let D_FGC = settings.get_string('dark-fg-color');
        let L_BGC = settings.get_string('light-bg-color');
        let L_FGC = settings.get_string('light-fg-color');
        D_BGC = D_BGC.match(/rgb\(\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*\)/i);
        D_FGC = D_FGC.match(/rgb\(\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*\)/i);
        L_BGC = L_BGC.match(/rgb\(\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*\)/i);
        L_FGC = L_FGC.match(/rgb\(\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*\)/i);
        return [
            [[D_BGC[1], D_BGC[2], D_BGC[3]], [L_BGC[1], L_BGC[2], L_BGC[3]]],
            [[D_FGC[1], D_FGC[2], D_FGC[3]], [L_FGC[1], L_FGC[2], L_FGC[3]]]
        ]
    }
    static getThemeColor(imagePath, modifier) {
        const source = GdkPixbuf.Pixbuf.new_from_file(imagePath);
        const pixels = source.get_pixels();
        const rowstride = source.get_rowstride();
        const n_channels = source.get_n_channels();
        const centerX = Math.round(source.get_width() / 2);
        const centerY = Math.round(source.get_height() / 2);
        const H = source.get_height();
        const W = source.get_width();
        const colors = new Map();
        for (let y = 0; y < H; y += Math.round(H / 100)) {
            for (let x = 0; x < W; x += Math.round(W / 100)) {
                // 計算像素在陣列中的偏移量
                const offset = y * rowstride + x * n_channels;

                // 取得像素的顏色分量
                const r = pixels[offset];
                const g = pixels[offset + 1];
                const b = pixels[offset + 2];
                const strRGB = [r, g, b].join(",");

                const distance = Math.sqrt(Math.pow(x - centerX, 2) + Math.pow(y - centerY, 2));

                // 計算最大距離
                const maxDistance = Math.sqrt(Math.pow(W / 2, 2) + Math.pow(H / 2, 2));

                // 使用高斯函數計算權重
                // 這裡使用標準差為最大距離的 1/4，您可以根據需要調整
                const sigma = maxDistance / 4;
                const weight = Math.exp(-(Math.pow(distance, 2) / (2 * Math.pow(sigma, 2))));

                const addValue = 1 * weight;

                if (colors.has(strRGB)) {
                    colors.set(strRGB, colors.get(strRGB) + addValue);
                } else {
                    colors.set(strRGB, addValue);
                }
            }
        }
        const entries = Array.from(colors.entries());
        entries.sort((a, b) => b[1] - a[1]);
        let hslC =  Colors.rgbToHsl(...entries[0][0].split(/\s*,\s*/).map(Number));
        if(modifier == "light"){
            hslC[2] = 60;
        }else {
            hslC[2] = 30;
        }
        return Colors.hslToRgb(...hslC);
    }
}