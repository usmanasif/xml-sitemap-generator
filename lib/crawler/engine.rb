module Crawler

  class Engine
    def initialize
      @ilps = Hash.new(0)
      @dpus = Hash.new(0)

      @url_map = Hash.new {|hash, key| hash[key] = []}
    end

    def start_crawling(url)
      Spidr.site(url) do |spider|
        spider.every_link do |origin, dest|
          @url_map[dest] << origin
          if dest.to_s.start_with?('http')
            @ilps[dest] = @url_map[dest].length if @url_map[dest].length > @ilps[dest]
            @dpus[dest] = dest.path.to_s.split('/').length > 0 ? (dest.path.to_s.split('/').length) - 1 : dest.path.to_s.split('/').length
          end
        end
      end
    end

    def avoid_zero_division(numerator, denominator)
      if denominator <= 0
        numerator
      else
        (numerator * 1.0) / denominator
      end
    end

    def link_nodes
      @url_map.keys.uniq
    end

    # number of Internal Links to a Page => ILP
    def number_of_internal_links_to_page(link)
      @ilps[link]
    end

    # Depth of Page in URL => DPU
    def depth_of_page_in_url(link)
      @dpus[link]
    end

    # Link Quotient => LQ = ILP / MAX ( ALL ( ILP))
    def link_quotient(link)
      self.avoid_zero_division(self.number_of_internal_links_to_page(link), @ilps.values.max)
    end

    # Depth of Index => DI = 1 / (DPU / MAX(ALL(DPU)))
    def depth_of_index(link)
        self.avoid_zero_division(1, self.avoid_zero_division(self.depth_of_page_in_url(link), @dpus.values.max))
    end

    # Depth Quotient => DQ = DI / MAX(ALL(DI))
    def depth_quotient(link, maximum_depth_of_index)
      self.avoid_zero_division(self.depth_of_index(link), maximum_depth_of_index)
    end

    def maximum_depth_of_index
      maximum_value = 0
      self.link_nodes.each do |link|
        if link.to_s.start_with?('http')
          di = self.depth_of_index(link)

          maximum_value = di if maximum_value < di
        end
      end
      maximum_value
    end

    def maximum_dq_lq_product(maximum_di)
      maximum_value = 0
      self.link_nodes.each do |link|
        if link.to_s.start_with?('http')
          dq = self.depth_quotient(link, maximum_di)
          lq = self.link_quotient(link)

          product = dq * lq

          maximum_value = product if maximum_value < product
        end
      end
      maximum_value
    end

    # Raw Priority => RP = ((0.35 * DQ) + (0.65 * LQ) / MAX(ALL(DQ * LQ))
    def raw_priority(link, maximum_depth_of_index, maximum_dq_lq_product)
      dq = self.depth_quotient(link, maximum_depth_of_index)
      lq = self.link_quotient(link)
      self.avoid_zero_division(((0.35 * dq) + (0.65 * lq)), maximum_dq_lq_product)
    end
  end
end