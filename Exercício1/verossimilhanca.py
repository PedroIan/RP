import numpy as np

def calculoVerossimilhanca(sigma1, sigma2, media1, media2, inputX, inputY, coeficienteCorrelacao = 0):
    expoente = (((inputX - media1)/sigma1)^2 + ((inputY - media2)/sigma2)^2 - 2*coeficienteCorrelacao*((inputX - media1)/sigma1)*((inputY - media2)/sigma2))/(2*(1 - coeficienteCorrelacao^2))
    return np.e^expoente/(2*np.pi*sigma1*sigma2*np.sqrt(1 - coeficienteCorrelacao^2))