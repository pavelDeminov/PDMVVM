
Pod::Spec.new do |s|

  s.name         = "PDMVVM"
  s.version      = "0.0.1"

  s.platform = :ios
  s.ios.deployment_target = '8.0'

  s.summary      = "Template for implementation MVVM Pattern"

  s.description  = <<-DESC
Template for implementation MVVM Pattern
                   DESC

  s.homepage     = "https://github.com/sindanar/PDMVVM"

  s.license      = { :type => "MIT", :file => "LICENSE" }


  s.author             = { "Pavel Deminov" => "pavel.d.work@gmail.com" }

  s.source       = { :git => "https://github.com/sindanar/PDMVVM.git", :tag => "v0.0.1" }

  s.frameworks = 'CoreData'

  s.public_header_files = 'Example/PDMVVM/PDMVVM/PDMVVM/PDMVVM.h'
  s.source_files = 'Example/PDMVVM/PDMVVM/PDMVVM/PDMVVM.h'


  s.subspec 'Protocols' do |protocols|    
    protocols.source_files = "Example/PDMVVM/PDMVVM/PDMVVM/Protocols/**/*.{h,m}"
  end
  
  s.subspec "Models" do | models |
    models.source_files = "Example/PDMVVM/PDMVVM/PDMVVM/Models/**/*.{h,m}"
    models.dependency 'PDMVVM/Protocols'
  end

  s.subspec "Adapters" do | adapters |
    adapters.source_files = "Example/PDMVVM/PDMVVM/PDMVVM/Adapters/**/*.{h,m}"
    adapters.dependency 'PDMVVM/Protocols'

  end

  s.subspec "Views" do | views |
    views.source_files = "Example/PDMVVM/PDMVVM/PDMVVM/Views/**/*.{h,m}"
  end

  s.subspec "Builders" do | builders |
    builders.source_files = "Example/PDMVVM/PDMVVM/PDMVVM/Builders/**/*.{h,m}"
    builders.dependency 'PDMVVM/Views'
  end
  
 s.subspec "Base" do |base |
    base.source_files = "Example/PDMVVM/PDMVVM/PDMVVM/Base/**/*.{h,m}"
    base.dependency 'PDMVVM/Protocols'
    base.dependency 'PDMVVM/Models'
    base.dependency 'PDMVVM/Adapters'
    base.dependency 'PDMVVM/Views'
  end

  s.subspec "CollectionView" do |collectionView |
    collectionView.source_files = "Example/PDMVVM/PDMVVM/PDMVVM/CollectionView/**/*.{h,m}"
    collectionView.dependency 'PDMVVM/Base'
    collectionView.dependency 'PDMVVM/Protocols'
    collectionView.dependency 'PDMVVM/Models'
    collectionView.dependency 'PDMVVM/Adapters'
    collectionView.dependency 'PDMVVM/Views'
  end
	
  s.subspec "TableView" do | tableView |
    tableView.source_files = "Example/PDMVVM/PDMVVM/PDMVVM/TableView/**/*.{h,m}"
    tableView.dependency 'PDMVVM/Base'
    tableView.dependency 'PDMVVM/Protocols'
    tableView.dependency 'PDMVVM/Models'
    tableView.dependency 'PDMVVM/Adapters'
    tableView.dependency 'PDMVVM/Views'
  end
	
  s.subspec "ScrollView" do | scrollView |
    scrollView.source_files = "Example/PDMVVM/PDMVVM/PDMVVM/ScrollView/**/*.{h,m}"
    scrollView.dependency 'PDMVVM/Base'
    scrollView.dependency 'PDMVVM/Protocols'
    scrollView.dependency 'PDMVVM/Models'
    scrollView.dependency 'PDMVVM/Adapters'
    scrollView.dependency 'PDMVVM/Views'
  end

end
