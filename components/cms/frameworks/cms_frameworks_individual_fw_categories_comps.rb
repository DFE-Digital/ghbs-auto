# frozen_string_literal: true

class CmsFrameworksIndividualFwCategoriesComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def text_page_heading_edit
    find(:xpath, "//main[@id='main-content']/span[1]")
  end

  def button_save_changes
    find(:xpath, "//button[text()='Save changes']")
  end

  def button_cancel
    find(:xpath, "//a[text()='Cancel']")
  end

  ### Audit / Finance ###
  def label_audit_accessibility
    find(:xpath, "//label[normalize-space()='Audit Accessibility (buildings and digital)']")
  end

  def checkbox_audit_accessibility
    label_audit_accessibility.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_audit_financial
    find(:xpath, "//label[normalize-space()='Audit Financial']")
  end

  def checkbox_audit_financial
    label_audit_financial.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_audit_safeguarding
    find(:xpath, "//label[normalize-space()='Audit Safeguarding']")
  end

  def checkbox_audit_safeguarding
    label_audit_safeguarding.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_books
    find(:xpath, "//label[normalize-space()='Books']")
  end

  def checkbox_books
    label_books.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_insurance
    find(:xpath, "//label[normalize-space()='Insurance']")
  end

  def checkbox_insurance
    label_insurance.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_leasing
    find(:xpath, "//label[normalize-space()='Leasing']")
  end

  def checkbox_leasing
    label_leasing.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_passenger_transport
    find(:xpath, "//label[normalize-space()='Passenger transport']")
  end

  def checkbox_passenger_transport
    label_passenger_transport.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_property_leasing_agents
    find(:xpath, "//label[normalize-space()='Property leasing agents']")
  end

  def checkbox_property_leasing_agents
    label_property_leasing_agents.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_spend_analysis
    find(:xpath, "//label[normalize-space()='Spend Analysis']")
  end

  def checkbox_spend_analysis
    label_spend_analysis.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_stationery_supply_office_supplies
    find(:xpath, "//label[normalize-space()='Stationery supply & office supplies']")
  end

  def checkbox_stationery_supply_office_supplies
    label_stationery_supply_office_supplies.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_vehicle_hire_purchase
    find(:xpath, "//label[normalize-space()='Vehicle hire & purchase']")
  end

  def checkbox_vehicle_hire_purchase
    label_vehicle_hire_purchase.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_other_bs
    find(:xpath, "//label[normalize-space()='Other (BS)']")
  end

  def checkbox_other_bs
    label_other_bs.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  ### Catering ###
  def label_breakfast_club
    find(:xpath, "//label[normalize-space()='Breakfast Club']")
  end

  def checkbox_breakfast_club
    label_breakfast_club.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_catering_equipment
    find(:xpath, "//label[normalize-space()='Catering Equipment']")
  end

  def checkbox_catering_equipment
    label_catering_equipment.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_catering_services
    find(:xpath, "//label[normalize-space()='Catering Services']")
  end

  def checkbox_catering_services
    label_catering_services.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_other_catering
    find(:xpath, "//label[normalize-space()='Other (Catering)']")
  end

  def checkbox_other_catering
    label_other_catering.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  ### Energy ###

  def label_decarbonisation
    find(:xpath, "//label[normalize-space()='Decarbonisation']")
  end

  def checkbox_decarbonisation
    label_decarbonisation.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_dfe_energy_for_schools_service
    find(:xpath, "//label[normalize-space()='DfE Energy for Schools service']")
  end

  def checkbox_dfe_energy_for_schools_service
    label_dfe_energy_for_schools_service.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_electricity
    find(:xpath, "//label[normalize-space()='Electricity']")
  end

  def checkbox_electricity
    label_electricity.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_gas
    find(:xpath, "//label[normalize-space()='Gas']")
  end

  def checkbox_gas
    label_gas.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_other_fuels
    find(:xpath, "//label[normalize-space()='Other fuels']")
  end

  def checkbox_other_fuels
    label_other_fuels.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_solar
    find(:xpath, "//label[normalize-space()='Solar']")
  end

  def checkbox_solar
    label_solar.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_other_energy
    find(:xpath, "//label[normalize-space()='Other (Energy)']")
  end

  def checkbox_other_energy
    label_other_energy.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  ### FM / Estates ###

  def label_boilers_and_plumbing_services
    find(:xpath, "//label[normalize-space()='Boilers and plumbing services']")
  end

  def checkbox_boilers_and_plumbing_services
    label_boilers_and_plumbing_services.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_building_maintenance_bms
    find(:xpath, "//label[normalize-space()='Building maintenance & BMS']")
  end

  def checkbox_building_maintenance_bms
    label_building_maintenance_bms.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_cleaning_products
    find(:xpath, "//label[normalize-space()='Cleaning Products']")
  end

  def checkbox_cleaning_products
    label_cleaning_products.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_cleaning_services
    find(:xpath, "//label[normalize-space()='Cleaning Services']")
  end

  def checkbox_cleaning_services
    label_cleaning_services.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_fire_safety_goods_systems
    find(:xpath, "//label[normalize-space()='Fire Safety (Goods & Systems)']")
  end

  def checkbox_fire_safety_goods_systems
    label_fire_safety_goods_systems.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_furniture
    find(:xpath, "//label[normalize-space()='Furniture']")
  end

  def checkbox_furniture
    label_furniture.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_grounds_winter_maintenance
    find(:xpath, "//label[normalize-space()='Grounds & Winter Maintenance']")
  end

  def checkbox_grounds_winter_maintenance
    label_grounds_winter_maintenance.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_mechanical_electrical_systems
    find(:xpath, "//label[normalize-space()='Mechanical & Electrical Systems']")
  end

  def checkbox_mechanical_electrical_systems
    label_mechanical_electrical_systems.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_mugas
    find(:xpath, "//label[normalize-space()='MUGAs']")
  end

  def checkbox_mugas
    label_mugas.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_ppe
    find(:xpath, "//label[normalize-space()='PPE']")
  end

  def checkbox_ppe
    label_ppe.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_removal_relocation
    find(:xpath, "//label[normalize-space()='Removal & relocation']")
  end

  def checkbox_removal_relocation
    label_removal_relocation.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_security_cctv
    find(:xpath, "//label[normalize-space()='Security & CCTV']")
  end

  def checkbox_security_cctv
    label_security_cctv.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_statutory_testing_fm_compliance
    find(:xpath, "//label[normalize-space()='Statutory testing & FM Compliance']")
  end

  def checkbox_statutory_testing_fm_compliance
    label_statutory_testing_fm_compliance.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_uniform
    find(:xpath, "//label[normalize-space()='Uniform']")
  end

  def checkbox_uniform
    label_uniform.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_vending_machine
    find(:xpath, "//label[normalize-space()='Vending Machine']")
  end

  def checkbox_vending_machine
    label_vending_machine.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_waste_management
    find(:xpath, "//label[normalize-space()='Waste management']")
  end

  def checkbox_waste_management
    label_waste_management.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_water_drains_sewerage
    find(:xpath, "//label[normalize-space()='Water, drains & sewerage']")
  end

  def checkbox_water_drains_sewerage
    label_water_drains_sewerage.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_other_fm
    find(:xpath, "//label[normalize-space()='Other (FM)']")
  end

  def checkbox_other_fm
    label_other_fm.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  ### ICT ###
  def label_av_displays
    find(:xpath, "//label[normalize-space()='AV Displays']")
  end

  def checkbox_av_displays
    label_av_displays.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_broadband_infrastructure
    find(:xpath, "//label[normalize-space()='Broadband Infrastructure']")
  end

  def checkbox_broadband_infrastructure
    label_broadband_infrastructure.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_broadband_service
    find(:xpath, "//label[normalize-space()='Broadband service']")
  end

  def checkbox_broadband_service
    label_broadband_service.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_cloud_saas
    find(:xpath, "//label[normalize-space()='Cloud SaaS']")
  end

  def checkbox_cloud_saas
    label_cloud_saas.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_curriculum_content
    find(:xpath, "//label[normalize-space()='Curriculum Content']")
  end

  def checkbox_curriculum_content
    label_curriculum_content.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_cyber_services
    find(:xpath, "//label[normalize-space()='Cyber services']")
  end

  def checkbox_cyber_services
    label_cyber_services.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_hosting_storage
    find(:xpath, "//label[normalize-space()='Hosting & Storage']")
  end

  def checkbox_hosting_storage
    label_hosting_storage.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_laptops
    find(:xpath, "//label[normalize-space()='Laptops']")
  end

  def checkbox_laptops
    label_laptops.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_mfd
    find(:xpath, "//label[normalize-space()='MFD']")
  end

  def checkbox_mfd
    label_mfd.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_mis
    find(:xpath, "//label[normalize-space()='MIS']")
  end

  def checkbox_mis
    label_mis.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_os_software
    find(:xpath, "//label[normalize-space()='OS Software']")
  end

  def checkbox_os_software
    label_os_software.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_peripherals
    find(:xpath, "//label[normalize-space()='Peripherals']")
  end

  def checkbox_peripherals
    label_peripherals.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_platforms_vles
    find(:xpath, "//label[normalize-space()='Platforms (VLEs)']")
  end

  def checkbox_platforms_vles
    label_platforms_vles.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_server_configuration_support
    find(:xpath, "//label[normalize-space()='Server Configuration & Support']")
  end

  def checkbox_server_configuration_support
    label_server_configuration_support.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_switches_routers
    find(:xpath, "//label[normalize-space()='Switches & Routers']")
  end

  def checkbox_switches_routers
    label_switches_routers.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_telecoms_broadband
    find(:xpath, "//label[normalize-space()='Telecoms & Broadband']")
  end

  def checkbox_telecoms_broadband
    label_telecoms_broadband.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_websites
    find(:xpath, "//label[normalize-space()='Websites']")
  end

  def checkbox_websites
    label_websites.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_other_ict
    find(:xpath, "//label[normalize-space()='Other (ICT)']")
  end

  def checkbox_other_ict
    label_other_ict.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  ### Professional Services ###
  def label_consultancy
    find(:xpath, "//label[normalize-space()='Consultancy']")
  end

  def checkbox_consultancy
    label_consultancy.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_hr
    find(:xpath, "//label[normalize-space()='HR']")
  end

  def checkbox_hr
    label_hr.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_legal_services
    find(:xpath, "//label[normalize-space()='Legal Services']")
  end

  def checkbox_legal_services
    label_legal_services.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_payroll
    find(:xpath, "//label[normalize-space()='Payroll']")
  end

  def checkbox_payroll
    label_payroll.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_recruitment_of_other_staff
    find(:xpath, "//label[normalize-space()='Recruitment of other staff']")
  end

  def checkbox_recruitment_of_other_staff
    label_recruitment_of_other_staff.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_recruitment_screening
    find(:xpath, "//label[normalize-space()='Recruitment screening']")
  end

  def checkbox_recruitment_screening
    label_recruitment_screening.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_specialist_professional_services
    find(:xpath, "//label[normalize-space()='Specialist professional services']")
  end

  def checkbox_specialist_professional_services
    label_specialist_professional_services.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_supply_teachers_agency_workers
    find(:xpath, "//label[normalize-space()='Supply Teachers & Agency workers']")
  end

  def checkbox_supply_teachers_agency_workers
    label_supply_teachers_agency_workers.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_other_ps
    find(:xpath, "//label[normalize-space()='Other (PS)']")
  end

  def checkbox_other_ps
    label_other_ps.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  ### Utilities ###
  def label_water
    find(:xpath, "//label[normalize-space()='Water']")
  end

  def checkbox_water
    label_water.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_other_utilities
    find(:xpath, "//label[normalize-space()='Other (Utilities)']")
  end

  def checkbox_other_utilities
    label_other_utilities.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  ### Registry ###

  def checkbox_label_pairs
    [
      # Audit / Finance
      %i[checkbox_audit_accessibility label_audit_accessibility],
      %i[checkbox_audit_financial label_audit_financial],
      %i[checkbox_audit_safeguarding label_audit_safeguarding],
      %i[checkbox_books label_books],
      %i[checkbox_insurance label_insurance],
      %i[checkbox_leasing label_leasing],
      %i[checkbox_passenger_transport label_passenger_transport],
      %i[checkbox_property_leasing_agents label_property_leasing_agents],
      %i[checkbox_spend_analysis label_spend_analysis],
      %i[checkbox_stationery_supply_office_supplies label_stationery_supply_office_supplies],
      %i[checkbox_vehicle_hire_purchase label_vehicle_hire_purchase],
      %i[checkbox_other_bs label_other_bs],

      # Catering
      %i[checkbox_breakfast_club label_breakfast_club],
      %i[checkbox_catering_equipment label_catering_equipment],
      %i[checkbox_catering_services label_catering_services],
      %i[checkbox_other_catering label_other_catering],

      # Energy
      %i[checkbox_decarbonisation label_decarbonisation],
      %i[checkbox_dfe_energy_for_schools_service label_dfe_energy_for_schools_service],
      %i[checkbox_electricity label_electricity],
      %i[checkbox_gas label_gas],
      %i[checkbox_other_fuels label_other_fuels],
      %i[checkbox_solar label_solar],
      %i[checkbox_other_energy label_other_energy],

      # FM / Estates
      %i[checkbox_boilers_and_plumbing_services label_boilers_and_plumbing_services],
      %i[checkbox_building_maintenance_bms label_building_maintenance_bms],
      %i[checkbox_cleaning_products label_cleaning_products],
      %i[checkbox_cleaning_services label_cleaning_services],
      %i[checkbox_fire_safety_goods_systems label_fire_safety_goods_systems],
      %i[checkbox_furniture label_furniture],
      %i[checkbox_grounds_winter_maintenance label_grounds_winter_maintenance],
      %i[checkbox_mechanical_electrical_systems label_mechanical_electrical_systems],
      %i[checkbox_mugas label_mugas],
      %i[checkbox_ppe label_ppe],
      %i[checkbox_removal_relocation label_removal_relocation],
      %i[checkbox_security_cctv label_security_cctv],
      %i[checkbox_statutory_testing_fm_compliance label_statutory_testing_fm_compliance],
      %i[checkbox_uniform label_uniform],
      %i[checkbox_vending_machine label_vending_machine],
      %i[checkbox_waste_management label_waste_management],
      %i[checkbox_water_drains_sewerage label_water_drains_sewerage],
      %i[checkbox_other_fm label_other_fm],

      # ICT
      %i[checkbox_av_displays label_av_displays],
      %i[checkbox_broadband_infrastructure label_broadband_infrastructure],
      %i[checkbox_broadband_service label_broadband_service],
      %i[checkbox_cloud_saas label_cloud_saas],
      %i[checkbox_curriculum_content label_curriculum_content],
      %i[checkbox_cyber_services label_cyber_services],
      %i[checkbox_hosting_storage label_hosting_storage],
      %i[checkbox_laptops label_laptops],
      %i[checkbox_mfd label_mfd],
      %i[checkbox_mis label_mis],
      %i[checkbox_os_software label_os_software],
      %i[checkbox_peripherals label_peripherals],
      %i[checkbox_platforms_vles label_platforms_vles],
      %i[checkbox_server_configuration_support label_server_configuration_support],
      %i[checkbox_switches_routers label_switches_routers],
      %i[checkbox_telecoms_broadband label_telecoms_broadband],
      %i[checkbox_websites label_websites],
      %i[checkbox_other_ict label_other_ict],

      # Professional Services
      %i[checkbox_consultancy label_consultancy],
      %i[checkbox_hr label_hr],
      %i[checkbox_legal_services label_legal_services],
      %i[checkbox_payroll label_payroll],
      %i[checkbox_recruitment_of_other_staff label_recruitment_of_other_staff],
      %i[checkbox_recruitment_screening label_recruitment_screening],
      %i[checkbox_specialist_professional_services label_specialist_professional_services],
      %i[checkbox_supply_teachers_agency_workers label_supply_teachers_agency_workers],
      %i[checkbox_other_ps label_other_ps],

      # Supply / Utilities
      %i[checkbox_water label_water],
      %i[checkbox_other_utilities label_other_utilities],
    ]
  end
end
