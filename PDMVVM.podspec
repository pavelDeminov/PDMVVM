
Pod::Spec.new do |s|

  s.name         = "PDMVVM"
  s.version      = "0.0.1"

  s.platform = :ios
  s.ios.deployment_target = '9.0'

  s.summary      = "Template for implementation MVVM Pattern"

  s.description  = <<-DESC
Template for implementation MVVM Pattern
                   DESC

  s.homepage     = "https://github.com/sindanar/PDMVVM"

  s.license      = { :type => "MIT", :file => "LICENSE" }


  s.author             = { "Pavel Deminov" => "pavel.d.work@gmail.com" }

  s.source       = { :git => "https://github.com/sindanar/PDMVVM.git", :tag => "v0.0.1" }


  s.subspec 'Protocols' do |protocols|    
    protocols.source_files = "PDMVVM/Protocols/**/*.swift"
  end
  
  s.subspec "Models" do | models |
    models.source_files = "PDMVVM/Models/**/*.swift"
  end


  s.subspec "Views" do | views |
    views.source_files = "PDMVVM/Views/**/*.swift"
  end

  s.subspec "ViewControllers" do | viewControllers |
    viewControllers = "PDMVVM/ViewControllers/**/*.swift"
  end

  s.subspec "ViewModels" do | viewModels |
    viewModels = "PDMVVM/ViewModels/**/*.swift"
  end


end
