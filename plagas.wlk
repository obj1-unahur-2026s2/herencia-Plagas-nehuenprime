class Barrio {
  var elementos = [] 

  method esCopado() {
    return elementos.count({elemento => elemento.esBueno()}) > elementos.count({elemento => !elemento.esBueno()})
  }
}

class Hogar{
  var nivelMugre
  var confort 

  method esBueno() {
    return nivelMugre <= confort / 2
  }
  method ataquePlaga(unaPlaga) {
    nivelMugre = nivelMugre + unaPlaga.nivelDeDaño()
  }
}

class Huerta{
  var capacidadProduccion 

  method esBueno() {
    return capacidadProduccion > valorASuperar.valor()
  }
  method ataquePlaga(unaPlaga) {
    if(unaPlaga.transmiteEnfermedades()) capacidadProduccion = capacidadProduccion - (unaPlaga.nivelDeDaño() * 0.1 + 10) else capacidadProduccion = capacidadProduccion - unaPlaga.nivelDeDaño() * 0.1   
  }
}

object valorASuperar {
  var valor = 0
  method valor() = valor
}

class Mascota{
  var nivelSalud

  method esBueno() {
    return nivelSalud > 250
  }
  method ataquePlaga(unaPlaga) {
    if(unaPlaga.transmiteEnfermedades()) nivelSalud = nivelSalud - unaPlaga.nivelDeDaño()
  }
}


class Plaga {
  var poblacion
  var transmiteEnfermedades

  method transmiteEnfermedades() {
      return poblacion >= 10 
  }
  method nivelDeDaño()
  method efectoPlaga(){
    poblacion = poblacion + (poblacion * 0.1)
  }
  method atacar(unElemento) {
    self.efectoPlaga()
    unElemento.ataquePlaga(self)
  }
}

class Cucaracha inherits Plaga{
  var peso = 8

  override method nivelDeDaño() = poblacion / 2
  override method transmiteEnfermedades() {
    return if(peso >= 10 && super()) transmiteEnfermedades else false
  }
  override method efectoPlaga() {
    super()
    peso = peso + 2
  }
}

class Pulga inherits Plaga{

  override method nivelDeDaño() = poblacion * 2

}

class Garrapata inherits Plaga{

  override method nivelDeDaño() = poblacion * 2

  override method efectoPlaga() {
    poblacion = poblacion + (poblacion * 0.2)
  }
}

class Mosquito inherits Plaga{

  override method nivelDeDaño() = poblacion
  override method transmiteEnfermedades() {
    return if(poblacion % 3 == 0 && super()) transmiteEnfermedades else false
  }
}