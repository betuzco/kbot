class Factura

    def initialize()
        @monto = 0.0
        @impuesto_monto = 0.0
        @descuento_monto = 0.0
        @total = 0.0
    end

    def doMonto(cantidad, precio_unitario)
        impuesto = 0.0
        @monto = (cantidad.to_i * precio_unitario.to_f)
        return "# #{cantidad} * $#{precio_unitario} \t= \t$#{@monto}"
    end
    
    def doImpuesto(estado)
        mapa_impuesto = {
            "UT" => 6.85, 
            "NV" => 8.00,
            "TX" => 6.85,
            "AL" => 4.00,
            "CA" => 8.25
        }
        
        impuesto = mapa_impuesto[estado.upcase]
        impuesto == nil ? impuesto = 0.0 : impuesto = mapa_impuesto[estado.upcase]

        @impuesto_monto = ((impuesto / 100) * @monto)
        return "CA(#{impuesto}) \t= \t$#{@impuesto_monto}"
    end

    def doDescuento()
        case @monto
            when 1000.00 .. 4999.99
                porcentaje_descuento = 3.00
            when 5000.00 .. 6999.99 
                porcentaje_descuento = 5.00
            when 7000.00 .. 9999.99 
                porcentaje_descuento = 7.00
            when 10000.00 .. 49999.99 
                porcentaje_descuento = 10.00
            when 50000.00 .. Float::INFINITY 
                porcentaje_descuento = 15.00
            else
                porcentaje_descuento = 0.00
        end

        @descuento_monto = ((porcentaje_descuento / 100) * @monto)
        return "DTO(%#{porcentaje_descuento}) \t= \t$#{@descuento_monto}"
    end

    def doTotal()
        @total = @monto + @impuesto_monto - @descuento_monto
        return "Total \t\t= \t$#{@total}"
    end
end

# Seccion para validar inputs
params = ARGV
if params.length != 3
    puts "Uso: ruby factura.rb <cantidad> <precio unitario> <estado>"
    exit
end

if params[0].to_i <= 0
    puts "La cantidad debe ser un valor entero y mayor a 0. [#{params[0]}]"
    exit
elsif params[1].to_f <= 0.0
    puts "El precio unitario debe ser un valor decimal y mayor a 0.0. [#{params[1]}]"
    exit
elsif params[2].length != 2
    puts "El estado debe ser una clave de estado a dos posiciones. [#{params[2]}]"
    exit
end

factura = Factura.new()
puts factura.doMonto(params[0], params[1])
puts factura.doImpuesto(params[2])
puts factura.doDescuento()
puts factura.doTotal()

puts number_to_currency(1234567890.50)
