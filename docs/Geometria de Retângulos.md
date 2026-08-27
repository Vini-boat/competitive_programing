---
title: Geometria de Retângulos
author: Vinicius de Ávila Bezerra
---

> **CPH:** — o cap. 29 (p. 265–274) é geometria geral (vetores, produto vetorial, `complex`);
> retângulo de lados paralelos aos eixos **não** está no livro
> **IUSACO:** 7.1 Square and Rectangle Geometry, p. 26 — só prosa, sem fórmula
> **USACO Guide:** <https://usaco.guide/bronze/rect-geo?lang=cpp> — **é a única fonte com o
> código em C++**: `area()`, `intersect()` e `inter_area()`, na convenção
> `bl_x, bl_y, tr_x, tr_y` (bottom-left / top-right)
> **Relacionado:** CPH cap. 30 Sweep line, p. 275 (quando forem *muitos* retângulos)

**Gatilho:** 2 ou 3 retângulos de lados paralelos aos eixos; área da união ou da interseção.
Com poucos retângulos, desenhar os casos no papel resolve.

<!-- corpo: escrever com as minhas palavras -->


# Finding area

The formula for finding the area of an individual rectangle is $w \cdot l$.

length is the length of the vertical sides, and width is the length of the horizontal sides.

$width = tr_x - bl_x$

$length = tr_y - bl_y$

$area = width \cdot length$

```cpp
long long area(int bl_x, int bl_y, int tr_x, int tr_y) {
	long long length = tr_y - bl_y;
	long long width = tr_x - bl_x;
	return length * width;
}
```

# Checking if two rectangles intersect

Given two rectangles a and b, there are only two cases where they do not intersect:

- $tr_{a_y} \le bl_{b_y}$  ou  $bl_{a_y} \ge tr_{b_y}$
- $bl_{a_x} \ge tr_{b_x}$  ou  $tr_{a_x} \le bl_{b_x}$

In all other cases, the rectangles intersect.

```cpp
bool intersect(vector<int> s1, vector<int> s2) {
	int bl_a_x = s1[0], bl_a_y = s1[1], tr_a_x = s1[2], tr_a_y = s1[3];
	int bl_b_x = s2[0], bl_b_y = s2[1], tr_b_x = s2[2], tr_b_y = s2[3];

	// no overlap
	if (bl_a_x >= tr_b_x || tr_a_x <= bl_b_x || bl_a_y >= tr_b_y || tr_a_y <= bl_b_y) {
		return false;
	} else {
		return true;
	}
}
```

# Finding area of intersection

We'll assume that the shape formed by the intersection of two rectangles is itself a rectangle.

First, we'll find this rectangle's length and width.

$width = \min(tr_{a_x}, tr_{b_x}) - \max(bl_{a_x}, bl_{b_x})$

$length = \min(tr_{a_y}, tr_{b_y}) - \max(bl_{a_y}, bl_{b_y})$

If either of these values are negative, the rectangles do not intersect. If they are zero, the rectangles intersect at a single point. Multiply the length and width to find the overlapping area.

```cpp
int inter_area(vector<int> s1, vector<int> s2) {
	int bl_a_x = s1[0], bl_a_y = s1[1], tr_a_x = s1[2], tr_a_y = s1[3];
	int bl_b_x = s2[0], bl_b_y = s2[1], tr_b_x = s2[2], tr_b_y = s2[3];

	return ((min(tr_a_x, tr_b_x) - max(bl_a_x, bl_b_x)) *
	        (min(tr_a_y, tr_b_y) - max(bl_a_y, bl_b_y)));
}
```