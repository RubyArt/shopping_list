module Support
  module Helpers
    def reload_page
      visit(page.current_url)
    end

    def using_second_browser(&block)
      # NOTE: Using the same session name everywhere to save spec time.
      Capybara.using_session(:second_browser) do
        Capybara.page.driver.resize('1920', '1080') unless page.mode == :rack_test
      end
      Capybara.using_session(:second_browser, &block)
    end

    def wait_for_ajax
      Timeout.timeout(Capybara.default_max_wait_time) do
        loop until page.evaluate_script('jQuery.active').zero?
      end
    end
  end
end
