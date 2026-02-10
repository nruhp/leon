$seoMap = @{
    "leon-ceramics.html" = @{
        Title = "S.K. Industries | Premium Stoneware & Ceramic Manufacturer"
        Description = "Leading Stoneware Manufacturer in Khurja. We supply Fine Bone China, custom ceramic manufacturing, and hotelware for global brands. ISO 9001:2015 Certified."
        Keywords = "stoneware manufacturer, ceramic manufacturer khurja, fine bone china suppliers, custom pottery india, hotelware manufacturers, sk industries"
    }
    "company-profile.html" = @{
        Title = "About S.K. Industries | Legacy of Ceramic Excellence"
        Description = "Discover the heritage of S.K. Industries (Leon Ceramics) in Khurja. Since 2017, we have been crafting premium stoneware and packaging fine bone china for global brands."
        Keywords = "S.K. Industries profile, Leon Ceramics history, ceramic factory khurja, stoneware manufacturing process, clay craft india"
    }
    "products.html" = @{
        Title = "Ceramic Product Catalog | Wholesale Stoneware & Bone China"
        Description = "Explore our complete range of ceramic products including dinner sets, tea sets, mugs, and hotelware. Available for wholesale and custom orders."
        Keywords = "ceramic product catalog, wholesale dinnerware, bulk mugs supplier, stoneware collection, bone china range"
    }
    "tableware.html" = @{
        Title = "Dinner Sets & Tableware | Stoneware Manufacturer"
        Description = "Premium stoneware dinner sets, bowls, platters, and serving ware. Durable, chip-resistant, and elegant designs for homes and hotels."
        Keywords = "stoneware dinner sets, ceramic bowls manufacturer, serving platters bulk, dinnerware wholesale india, restaurant crockery"
    }
    "tea-coffee.html" = @{
        Title = "Tea & Coffee Sets | Mugs & Kettles | Leon Ceramics"
        Description = "Exquisite ceramic tea sets, coffee mugs, kettles, and kullarhs. Perfect for cafes, corporate gifting, and retail collections."
        Keywords = "ceramic coffee mugs, tea sets wholesale, clay kullarhs, custom printed mugs, cafe crockery suppliers"
    }
    "hotelware.html" = @{
        Title = "Hotelware & HoReCa | Professional Dining Solutions"
        Description = "Specialized ceramic hotelware designed for high-frequency usage. Chip-resistant, dishwasher safe, and customizable for 5-star properties."
        Keywords = "hotelware suppliers india, restaurant crockery manufacturer, horeca ceramics, durable dinnerware for hotels, custom logo crockery"
    }
    "gift-items.html" = @{
        Title = "Corporate Gifting | Ceramic Gift Sets | Leon Ceramics"
        Description = "Unique ceramic gift sets for corporate events, weddings, and festivals. Custom branding and bulk packaging available."
        Keywords = "corporate gifting ceramics, ceramic gift sets india, diwali gifts bulk, custom logo mugs, employee gifting solutions"
    }
    "collections.html" = @{
        Title = "Curated Collections | Disney, India Circus & More"
        Description = "Browse our exclusive collections including Disney-themed ceramics, India Circus designs, and our signature Ebony range."
        Keywords = "licensed ceramic collections, disney ceramics india, india circus crockery, ebony stoneware, designer dinnerware"
    }
    "custom-manufacturing.html" = @{
        Title = "Custom Manufacturing | OEM & ODM Services | S.K. Industries"
        Description = "Partner with S.K. Industries for custom ceramic manufacturing. We offer OEM/ODM services for private labels, including shape development and decal printing."
        Keywords = "custom ceramic manufacturing, private label pottery, oem ceramics india, custom shape development, contract manufacturing ceramics"
    }
    "royal-collection.html" = @{
        Title = "The Royal Collection | Premium Bone China"
        Description = "Experience the luxury of our Royal Collection. Fine bone china with 24k gold plating, perfect for upscale dining and luxury gifting."
        Keywords = "fine bone china dinner sets, 24k gold plated crockery, luxury tableware, royal collection ceramics, premium bone china suppliers"
    }
    "modern-minimalist.html" = @{
        Title = "Modern Minimalist | Matte Stoneware Collection"
        Description = "Contemporary matte finish stoneware in earth tones. Minimalist designs for the modern home and trendy cafes."
        Keywords = "matte stoneware, minimalist dinnerware, earth tone ceramics, modern ceramic plates, matte finish crockery"
    }
    "contact-us.html" = @{
        Title = "Contact S.K. Industries | Ceramic Factory Khurja"
        Description = "Get in touch with S.K. Industries for wholesale inquiries, custom manufacturing, and factory visits in Khurja."
        Keywords = "contact ceramic factory, sk industries khurja address, wholesale enquiry ceramics, visit pottery factory"
    }
    "careers.html" = @{
        Title = "Careers at S.K. Industries | Join Our Team"
        Description = "Explore career opportunities at S.K. Industries. Join a leading ceramic manufacturer and grow your career in the pottery industry."
        Keywords = "ceramic industry jobs, jobs in khurja, pottery factory careers, manufacturing jobs india"
    }
    "csr-initiatives.html" = @{
        Title = "CSR Initiatives | Sustainable Manufacturing"
        Description = "Learn about our commitment to sustainable manufacturing, community development, and ethical labor practices in the ceramic industry."
        Keywords = "sustainable ceramics, ethical manufacturing india, ceramic industry csr, eco-friendly pottery"
    }
    "shipping-policy.html" = @{
        Title = "Shipping Policy | Leon Ceramics"
        Description = "Information regarding our shipping policies for wholesale and retail orders, including domestic and international delivery terms."
        Keywords = "shipping policy ceramics, wholesale delivery terms, international shipping pottery"
    }
    "terms-of-service.html" = @{
        Title = "Terms of Service | Leon Ceramics"
        Description = "Terms and conditions governing the use of our website and purchase of our ceramic products."
        Keywords = "terms of service, website terms, sale conditions ceramics"
    }
    "privacy-policy.html" = @{
        Title = "Privacy Policy | Leon Ceramics"
        Description = "Our privacy policy outlines how we collect, use, and protect your personal information."
        Keywords = "privacy policy, data protection ceramics website"
    }
    "product-detail.html" = @{
        Title = "Product Details | Leon Ceramics Catalogue"
        Description = "Detailed specifications and imagery for our premium ceramic products. Request a quote for bulk orders."
        Keywords = "ceramic product details, stoneware specifications, bulk order ceramics"
    }
}

foreach ($file in $seoMap.Keys) {
    if (Test-Path $file) {
        $content = Get-Content $file -Raw
        $seoDocs = $seoMap[$file]
        
        # 1. Update Title
        $newTitle = "<title>$($seoDocs.Title)</title>"
        $content = $content -replace '<title>.*?</title>', $newTitle
        
        # 2. Update/Insert Description
        $descTag = '<meta name="description" content="' + $seoDocs.Description + '">'
        if ($content -match '<meta name="description".*?>') {
            $content = $content -replace '<meta name="description".*?>', $descTag
        } else {
            # Insert after viewport meta
            $content = $content -replace '(<meta name="viewport".*?>)', "`$1`n    $descTag"
        }
        
        # 3. Update/Insert Keywords
        $kwTag = '<meta name="keywords" content="' + $seoDocs.Keywords + '">'
        if ($content -match '<meta name="keywords".*?>') {
            $content = $content -replace '<meta name="keywords".*?>', $kwTag
        } else {
            # Insert after description (which we just added/ensured)
            $content = $content -replace '(<meta name="description".*?>)', "`$1`n    $kwTag"
        }

        Set-Content -Path $file -Value $content
        Write-Host "Updated SEO for $file"
    } else {
        Write-Warning "File not found: $file"
    }
}
