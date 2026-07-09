import QtQuick

ListModel {
    id: resolutionModel

    // Desktop
    ListElement { os: "Desktop"; width: 2880; height: 1800; name: "Retina / WQXGA+ (2880 × 1800)" }
    ListElement { os: "Desktop"; width: 2560; height: 1600; name: "WQXGA (2560 × 1600)" }
    ListElement { os: "Desktop"; width: 2560; height: 1440; name: "WQHD / QHD / 1440p (2560 × 1440)" }
    ListElement { os: "Desktop"; width: 1920; height: 1200; name: "WUXGA (1920 × 1200)" }
    ListElement { os: "Desktop"; width: 1920; height: 1080; name: "Full HD / FHD / 1080p (1920 × 1080)" }
    ListElement { os: "Desktop"; width: 1680; height: 1050; name: "WSXGA+ (1680 × 1050)" }
    ListElement { os: "Desktop"; width: 1600; height: 1200; name: "UXGA (1600 × 1200)" }
    ListElement { os: "Desktop"; width: 1600; height: 900; name: "HD+ (1600 × 900)" }
    ListElement { os: "Desktop"; width: 1280; height: 1024; name: "SXGA (1280 × 1024)" }
    ListElement { os: "Desktop"; width: 1280; height: 720; name: "HD / 720p (1280 × 720)" }
    ListElement { os: "Desktop"; width: 1024; height: 768; name: "XGA (1024 × 768)" }
    ListElement { os: "Desktop"; width: 800; height: 600; name: "SVGA (800 × 600)" }
    ListElement { os: "Desktop"; width: 640; height: 480; name: "VGA (640 × 480)" }

    // iOS
    ListElement { os: "iOS"; width: 1206; height: 2622; name: "iPhone 16 Pro (1206 × 2622)" }
    ListElement { os: "iOS"; width: 1290; height: 2796; name: "iPhone 15 Pro Max / 14 Pro Max (1290 × 2796)" }
    ListElement { os: "iOS"; width: 1170; height: 2532; name: "iPhone 14 / 13 / 13 Pro / 12 / 12 Pro (1170 × 2532)" }
    ListElement { os: "iOS"; width: 1284; height: 2778; name: "iPhone 13 Pro Max / 12 Pro Max (1284 × 2778)" }
    ListElement { os: "iOS"; width: 1242; height: 2688; name: "iPhone 11 Pro Max / XS Max (1242 × 2688)" }
    ListElement { os: "iOS"; width: 828; height: 1792; name: "iPhone 11 / XR (828 × 1792)" }
    ListElement { os: "iOS"; width: 1080; height: 1920; name: "iPhone 8 Plus / 7 Plus / 6s Plus (1080 × 1920)" }
    ListElement { os: "iOS"; width: 750; height: 1334; name: "iPhone 8 / 7 / 6s / SE 3 (750 × 1334)" }
    ListElement { os: "iOS"; width: 640; height: 1136; name: "iPhone SE 1 / 5s (640 × 1136)" }

    // iPadOS
    ListElement { os: "iPadOS"; width: 2064; height: 2752; name: "iPad Pro 13\" M4/M5 (2064 × 2752)" }
    ListElement { os: "iPadOS"; width: 1668; height: 2420; name: "iPad Pro 11\" M4/M5 (1668 × 2420)" }
    ListElement { os: "iPadOS"; width: 2048; height: 2732; name: "iPad Pro 12.9\" / iPad Air 13\" (2048 × 2732)" }
    ListElement { os: "iPadOS"; width: 1668; height: 2388; name: "iPad Pro 11\" (1668 × 2388)" }
    ListElement { os: "iPadOS"; width: 1640; height: 2360; name: "iPad Air 11\" / 10.9\" (1640 × 2360)" }
    ListElement { os: "iPadOS"; width: 1640; height: 2360; name: "iPad 10.9\" (1640 × 2360)" }
    ListElement { os: "iPadOS"; width: 1620; height: 2160; name: "iPad 10.2\" (1620 × 2160)" }
    ListElement { os: "iPadOS"; width: 1536; height: 2048; name: "iPad 9.7\" / iPad Mini 4/5 (1536 × 2048)" }
    ListElement { os: "iPadOS"; width: 1488; height: 2266; name: "iPad Mini 6/7 (1488 × 2266)" }

    // Android
    ListElement { os: "Android"; width: 1440; height: 3200; name: "Android QHD+ (1440 × 3200)" }
    ListElement { os: "Android"; width: 1344; height: 2992; name: "Android QHD+ (1344 × 2992)" }
    ListElement { os: "Android"; width: 1280; height: 2800; name: "Android Foldable Cover / Inner Variant (1280 × 2800)" }
    ListElement { os: "Android"; width: 1220; height: 2712; name: "Android FHD+ High (1220 × 2712)" }
    ListElement { os: "Android"; width: 1080; height: 2640; name: "Android FHD+ Tall (1080 × 2640)" }
    ListElement { os: "Android"; width: 1080; height: 2460; name: "Android FHD+ (1080 × 2460)" }
    ListElement { os: "Android"; width: 1080; height: 2280; name: "Android FHD+ (1080 × 2280)" }
    ListElement { os: "Android"; width: 1080; height: 2220; name: "Android FHD+ (1080 × 2220)" }
    ListElement { os: "Android"; width: 1080; height: 2160; name: "Android FHD+ / 18:9 (1080 × 2160)" }
    ListElement { os: "Android"; width: 1080; height: 1920; name: "Android Full HD (1080 × 1920)" }
    ListElement { os: "Android"; width: 900; height: 1600; name: "Android HD+ (900 × 1600)" }
    ListElement { os: "Android"; width: 720; height: 1600; name: "Android HD+ (720 × 1600)" }
    ListElement { os: "Android"; width: 720; height: 1440; name: "Android HD+ / 18:9 (720 × 1440)" }
    ListElement { os: "Android"; width: 720; height: 1280; name: "Android HD (720 × 1280)" }

    // Android Tablet
    ListElement { os: "Android Tablet"; width: 2560; height: 1600; name:    "Android Tablet WQXGA (2560 × 1600)" }
    ListElement { os: "Android Tablet"; width: 2800; height: 1752; name:    "Android Tablet AMOLED Large (2800 × 1752)" }
    ListElement { os: "Android Tablet"; width: 2560; height: 1600; name:    "Android Tablet WQXGA (2560 × 1600)" }
    ListElement { os: "Android Tablet"; width: 2400; height: 1600; name:    "Android Tablet WUXGA+ (2400 × 1600)" }
    ListElement { os: "Android Tablet"; width: 2304; height: 1440; name:    "Android Tablet 16:10 (2304 × 1440)" }
    ListElement { os: "Android Tablet"; width: 2160; height: 1350; name:    "Android Tablet 16:10 (2160 × 1350)" }
    ListElement { os: "Android Tablet"; width: 2000; height: 1200; name:    "Android Tablet 2K (2000 × 1200)" }
    ListElement { os: "Android Tablet"; width: 1920; height: 1200; name:    "Android Tablet WUXGA (1920 × 1200)" }
    ListElement { os: "Android Tablet"; width: 1280; height: 800; name:     "Android Tablet WXGA (1280 × 800)" }
}
