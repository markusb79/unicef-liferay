! function(a) {
    "use strict";

    function b(a) {
        var b = getComputedStyle(a);
        this.units = {
            px: 1
        }, this.element = a;
        var c = function(a) {
            return a && a.length ? parseInt(a) : 0
        };
        this.margins = [b.marginTop, b.marginRight, b.marginBottom, b.marginLeft], this.margins = this.margins.map(c), this.borders = [b.borderTopWidth, b.borderRightWidth, b.borderBottomWidth, b.borderLeftWidth], this.borders = this.borders.map(c), this.paddings = [b.paddingTop, b.paddingRight, b.paddingBottom, b.paddingLeft], this.paddings = this.paddings.map(c), this.borderBox = {
            x: 0,
            y: 0,
            width: a.offsetWidth,
            height: a.offsetHeight
        }, this.marginBox = {
            x: -this.margins[3],
            y: -this.margins[0],
            width: a.offsetWidth + this.margins[1] + this.margins[3],
            height: a.offsetHeight + this.margins[0] + this.margins[2]
        };
        var d = this,
            e = ["borderTopLeftRadius", "borderTopRightRadius", "borderBottomRightRadius", "borderBottomLeftRadius"];
        this.borderBox.radii = e.map(function(a) {
            return a = b[a].split(/\s+/), [d.toPixels(a[0], d.borderBox.width), d.toPixels(a.length > 1 ? a[1] : a[0], d.borderBox.height)]
        }), this.cssFloat = b.cssFloat
    }

    function c(a, b, c) {
        return (c.x - a.x) * (b.y - a.y) - (b.x - a.x) * (c.y - a.y)
    }

    function d(a, b, d) {
        return Math.abs(c(a, b, d)) < 350
    }

    function e(a, b) {
        return a.x == b.x && a.y == b.y
    }

    function f(a, b, c) {
        return c.x >= Math.min(a.x, b.x) && c.x <= Math.max(a.x, b.x) && d(a, b, c)
    }

    function g() {}

    function h(a, b, c, d) {
        if (a.y >= c && a.y <= d) return {
            x1: a.x - b,
            x2: a.x + b
        };
        var e, f;
        return d < a.y ? (e = d - a.y, f = z(e, b, b), {
            x1: a.x - f,
            x2: a.x + f
        }) : (e = c - a.y, f = z(e, b, b), {
            x1: a.x - f,
            x2: a.x + f
        })
    }

    function i(a, b, c) {
        this.init(a, b, c)
    }

    function j(a, b) {
        var c = a.polygon.shapeMargin,
            d = b.x * c,
            e = b.y * c;
        this.anchorEdge = a, this.normalUnitVector = b;
        var f = {
                x: a.vertex1.x + d,
                y: a.vertex1.y + e
            },
            g = {
                x: a.vertex2.x + d,
                y: a.vertex2.y + e
            };
        this.init(a.polygon, f, g)
    }

    function k(a) {
        for (var b = 0, d = 1; d < a.length; ++d) {
            var e = a[d];
            (e.y < a[b].y || e.y == a[b].y && e.x < a[b].x) && (b = d)
        }
        var f = a[(b + 1) % a.length],
            g = a[(b + a.length - 1) % a.length];
        return c(g, a[b], f) < 0
    }

    function l(a, b, c) {
        if (this.m_vertices = a, this.fillRule = b, this.shapeMargin = c, a.length < 3) return this.m_edges = [], void(this.shapeMarginEdges = []);
        var e = [],
            f = a.length > 0 ? a[0].x : void 0,
            g = a.length > 0 ? a[0].y : void 0,
            h = f,
            l = g,
            m = k(a),
            n = 0;
        do {
            var o = this.nextEdgeVertexIndex(n, m);
            e.push(new i(this, a[n], a[o]));
            var p = a[n].x,
                q = a[n].y;
            f = Math.min(p, f), g = Math.min(q, g), h = Math.max(p, h), l = Math.max(q, l), n = o
        } while (0 !== n);
        for (var r, s = 0; s < e.length && e.length > 3;) r = (s + 1) % e.length, d(e[s].vertex1, e[s].vertex2, e[r].vertex2) ? (e[s].vertex2 = e[r].vertex2, e.splice(r, 1)) : s++;
        if (0 === c) this.shapeMarginEdges = e;
        else {
            for (var t = [], u = 0; u < e.length; u++) t.push(new j(e[u], e[u].outwardNormal())), t.push(new j(e[u], e[u].inwardNormal()));
            this.shapeMarginEdges = t
        }
        this.m_edges = e, this.bounds = new x(f - c, g - c, 2 * c + (h - f), 2 * c + (l - g))
    }

    function m(a, b) {
        return a.minX - b.minX
    }

    function n(a, b) {
        return b.x - a.x
    }

    function o(a, b) {
        return b.maxX - a.maxX
    }

    function p(a, b) {
        return a.x - b.x
    }

    function q(a, b, c) {
        this.y = a, this.startX = b, this.endX = c
    }

    function r(a, b) {
        this.intervals = [], this.yOffset = a, this.size = b;
        for (var c = 0; b > c; c++) this.intervals[c] = r.none;
        this.minY = -a, this.maxY = b - a
    }

    function s(a) {
        this.shapeMargin = a, this.xIntercepts = [];
        for (var b = 0; a >= b; b++) this.xIntercepts[b] = Math.sqrt(a * a - b * b)
    }

    function t(a, b) {
        console.log("Unable to load image ", a, ". It's probably missing or you've run into a CORS issue."), b && console.log("The exact problem was ", b)
    }

    function u(a, b, c) {
        var d = document.createElement("canvas");
        this.width = d.width = b, this.height = d.height = c;
        var e = d.getContext("2d");
        e.drawImage(a, 0, 0, b, c);
        try {
            this.imageData = e.getImageData(0, 0, b, c)
        } catch (f) {
            t(a.src, f)
        }
    }

    function v(a, b, c, d, e, f) {
        this.url = a, this.box = b, this.shapeImageThreshold = 256 * c, this.shapeMargin = d, this.clip = e, this.init(f)
    }

    function w(a, b) {
        this.width = a, this.height = b
    }

    function x(a, b, c, d) {
        this.x = a, this.y = b, this.width = c, this.height = d, this.maxX = a + c, this.maxY = b + d
    }

    function y(a, b, c, d, e) {
        this.rect = a, this.radii = {
            topLeft: b,
            topRight: c,
            bottomLeft: d,
            bottomRight: e
        }
    }

    function z(a, b, c) {
        return b * Math.sqrt(1 - a * a / (c * c))
    }

    function A(a, b, c) {
        return 0 === b ? 1 : Math.round(0 === a || c > a * b / 2 ? b : Math.sqrt(2 * c * (b / a)))
    }

    function B(a, b) {
        return a.maxX - b
    }

    function C(a, b) {
        return a.x + b
    }

    function D(a) {
        return a.x
    }

    function E(a) {
        return a.maxX
    }

    function F(a, b, c, d) {
        return function(e, f, g) {
            if (!this.rect.overlapsYRange(e, f)) return [{
                x: void 0,
                height: f - e
            }];
            var h = [];
            e < this.rect.y && h.push({
                x: void 0,
                height: this.rect.y - e
            });
            var i, j, k, l, m, n, o = a.call(this),
                p = b.call(this),
                q = new x(this.rect.x, o.maxY, this.rect.width, p.y - o.maxY);
            if (o.overlapsYRange(e, f))
                for (i = A(o.width, o.height, g), j = Math.max(o.y, e), k = Math.min(o.maxY, f), l = j; k > l; l += i) m = o.maxY - Math.min(l + i, k), n = z(m, o.width, o.height), h.push({
                    height: Math.min(i, k - l),
                    x: d(o, n)
                });
            if (j = Math.max(q.y, e), k = Math.min(q.maxY, f), q.overlapsYRange(e, f) && h.push({
                    x: c(q),
                    height: k - j
                }), p.overlapsYRange(e, f))
                for (i = A(p.width, p.height, g), j = Math.max(e, p.y), k = Math.min(p.maxY, f), l = j; k > l; l += i) m = l - p.y, n = z(m, p.width, p.height), h.push({
                    height: Math.min(i, k - l),
                    x: d(p, n)
                });
            return f > this.rect.maxY && h.push({
                x: void 0,
                height: f - this.rect.maxY
            }), h
        }
    }

    function G(a, b) {
        var c = a.r + b,
            d = new w(c, c);
        return new y(new x(a.cx - c, a.cy - c, 2 * c, 2 * c), d, d, d, d)
    }

    function H(a, b) {
        var c = new w(a.rx + b, a.ry + b);
        return new y(new x(a.cx - c.width, a.cy - c.height, 2 * c.width, 2 * c.height), c, c, c, c)
    }

    function I(a, b) {
        function c(a) {
            return new w(a[0] + b, a[1] + b)
        }
        var d = c(a.radii[0]),
            e = c(a.radii[1]),
            f = c(a.radii[2]),
            g = c(a.radii[3]),
            h = new x(a.x - b, a.y - b, a.width + 2 * b, a.height + 2 * b);
        return new y(h, d, e, g, f)
    }

    function J(a, b) {
        function c(a) {
            return new w(a[0] + b, a[1] + b)
        }
        var d = c(a.radii[0]),
            e = c(a.radii[1]),
            f = c(a.radii[2]),
            g = c(a.radii[3]),
            h = new x(-b, -b, a.width + 2 * b, a.height + 2 * b);
        return new y(h, d, e, g, f)
    }

    function K(a, b, c, d, e, f) {
        var g = new x(e.x, e.y, e.width, e.height);
        return new v(a, b, c, d, g, f)
    }

    function L(a, b) {
        return new l(a.points, a.fillRule, b)
    }

    function M(a, b) {
        var c, d = void 0 === a.shapeMargin ? 0 : a.shapeMargin;
        if (a.shape) {
            switch (a.shape.type) {
                case "circle":
                    c = G(a.shape, d);
                    break;
                case "ellipse":
                    c = H(a.shape, d);
                    break;
                case "inset":
                    c = I(a.shape, d), c.isRenderable() || c.adjustRadii();
                    break;
                case "polygon":
                    c = L(a.shape, d)
            }
            return b(), c
        }
        return a.url ? K(a.url, a.box, a.shapeImageThreshold, d, a.clip, b) : a.box ? (c = J(a.box, d), b(), c) : void console.error("Unrecognized shape")
    }

    function N(a) {
        this.metrics = new b(a);
        var c = {
            metrics: this.metrics,
            shapeOutside: a.getAttribute("data-shape-outside"),
            shapeMargin: a.getAttribute("data-shape-margin"),
            shapeImageThreshold: a.getAttribute("data-shape-image-threshold")
        };
        this.shapeValue = new R(c);
        var d = this;
        this.geometry = M(this.shapeValue, function() {
            d.ready = !0, d.callback && d.callback()
        })
    }

    function O(a) {
        this.scope = a;
        var b = document.currentScript;
        b || (b = document.getElementsByTagName("script"), b = b[b.length - 1]);
        var c = this,
            d = "false" !== b.getAttribute("data-auto-run");
        d && a.addEventListener && a.addEventListener("load", function() {
            c.run()
        })
    }

    function P(a, b) {
        var c, d = document.createElement("div");
        b.forEach(function(a) {
            var b = a.bottom - a.top,
                e = document.createElement("div");
            e.className = "sandbag", c = {
                cssFloat: a.cssFloat,
                width: a.offset + "px",
                height: b + "px",
                clear: a.cssFloat
            };
            for (var f in c) e.style[f] = c[f];
            d.appendChild(e)
        }), c = {
            position: "relative",
            width: "auto",
            height: "0",
            clear: "both",
            pointerEvents: "none"
        };
        for (var e in c) d.style[e] = c[e];
        var f, g = a.parentNode,
            h = getComputedStyle(g),
            i = parseFloat(h.borderTop) + parseFloat(h.borderBottom);
        c = {
            position: "absolute",
            top: "0",
            width: "100%",
            height: g.clientHeight - i,
            left: "0"
        }, f = document.createElement("div");
        for (e in c) f.style[e] = c[e];
        d.appendChild(f), a.parentNode && a.parentNode.insertBefore(d, a), f.appendChild(a), d.setAttribute("data-shape-outside-container", "true")
    }

    function Q(a, b) {
        var c;
        return function() {
            var d = this,
                e = arguments;
            clearTimeout(c), c = setTimeout(function() {
                c = null, a.apply(d, e)
            }, b)
        }
    }

    function R(a) {
        return a && a.metrics && a.shapeOutside ? (this.url = this.parseUrl(a.shapeOutside), this.box = this.parseBox(this.url ? "content-box" : a.shapeOutside, a.metrics), this.shape = this.parseBasicShape(a.shapeOutside, this.box, a.metrics), this.clip = this.computeClip(this.box, a.metrics), this.shapeMargin = this.parseShapeMargin(a.shapeMargin, this.box, a.metrics), void(this.shapeImageThreshold = this.parseShapeImageThreshold(a.shapeImageThreshold))) : void console.error("ShapeValue requires at least a metrics object and shape-outside string")
    }

    function S(a, b, c) {
        var d = c.reduce(function(a, b) {
                return a + b[0]
            }, 0),
            e = c.reduce(function(a, b) {
                return a + b[1]
            }, 0),
            f = c.reduce(function(a, b) {
                return a + b[2]
            }, 0),
            g = c.reduce(function(a, b) {
                return a + b[3]
            }, 0);
        a.x -= b * g, a.y -= b * d, a.width += b * (g + e), a.height += b * (d + f)
    }

    function T(a, b, c) {
        if (0 > b) return Math.max(a + b * c, 0);
        var d = Math.abs(a / c);
        return 1 > d ? Math.max(a + c * (1 + Math.pow(d - 1, 3)), 0) : a + c
    }

    function U(a, b, c) {
        var d = c.reduce(function(a, b) {
                return a + b[0]
            }, 0),
            e = c.reduce(function(a, b) {
                return a + b[1]
            }, 0),
            f = c.reduce(function(a, b) {
                return a + b[2]
            }, 0),
            g = c.reduce(function(a, b) {
                return a + b[3]
            }, 0);
        a[0][0] = T(a[0][0], b, g), a[0][1] = T(a[0][1], b, d), a[1][0] = T(a[1][0], b, e), a[1][1] = T(a[1][1], b, d), a[2][0] = T(a[2][0], b, e), a[2][1] = T(a[2][1], b, f), a[3][0] = T(a[3][0], b, g), a[3][1] = T(a[3][1], b, f)
    }

    function V(a, b) {
        return a.map(function(a) {
            return a[b]
        })
    }

    function W(a, b, c) {
        a = a.split(/\s+/);
        var d = "TopLeft",
            e = 0;
        switch (a[0]) {
            case "top":
            case "left":
                break;
            case "bottom":
            case "right":
                d = "BottomRight";
                break;
            case "center":
                e = b / 2;
                break;
            default:
                e = c.toPixels(a[0], b)
        }
        return a.length > 1 && (e = c.toPixels(a[1], b)), "TopLeft" === d ? e : b - e
    }

    function X(a, b, c, d) {
        return "closest-side" === a ? Math.min.apply(null, b) : "farthest-side" === a ? Math.max.apply(null, b) : d.toPixels(a, c)
    }

    function Y() {
        var a, b, c = document,
            d = [];
        if ("function" == typeof c.querySelectorAll) d = c.querySelectorAll('link[rel="stylesheet"], style'), d = Array.prototype.slice.call(d, 0);
        else {
            var e = c.getElementsByTagName("link");
            if (e.length)
                for (a = 0, b = e.length; b > a; a++) "stylesheet" === e[a].getAttribute("rel") && d.push(e[a]);
            for (e = c.getElementsByTagName("style"), a = 0, b = e.length; b > a; a++) d.push(e[a])
        }
        return d
    }

    function Z(a) {
        this.source = a, this.url = a.href || null, this.cssText = ""
    }

    function $(a) {
        return this instanceof $ ? (this.stylesheets = [], this.queueCount = 0, this.callback = a || function() {}, void this.init()) : new $(a)
    }

    function _(a) {
        this.callback = a || function() {};
        var b = this;
        new $(function(a) {
            b.onStylesLoaded(a)
        })
    }
    b.prototype.unitToPx = function(a) {
        if (this.units[a]) return this.units[a];
        var b = this.element.style.getPropertyValue("line-height");
        return this.element.style.setProperty("line-height", 1 + a), this.units[a] = parseFloat(getComputedStyle(this.element).getPropertyValue("line-height")), this.element.style.setProperty("line-height", b), this.units[a]
    }, b.prototype.getUnitsMap = function(a) {
        var b = ["em", "ex", "ch", "rem", "vw", "vh", "vmin", "vmax", "cm", "mm", "in", "px", "pt", "pc"],
            c = document.createElement("div");
        c.style.width = "0px", c.style.height = "0px", a.appendChild(c);
        var d = getComputedStyle(c),
            e = {};
        return b.forEach(function(a) {
            c.style.lineHeight = "1" + a, e[a] = parseFloat(d.lineHeight)
        }), c.parentNode.removeChild(c), e
    }, b.prototype.toPixels = function(a, b) {
        var c = /([\-0-9\.]*)([a-z%]*)/.exec(a);
        return c[1] = parseFloat(c[1]), c[2] ? "%" === c[2] ? c[1] * b / 100 : c[1] * this.unitToPx(c[2]) : c[1]
    }, g.prototype.init = function(a, b, c) {
        this.polygon = a, this.vertex1 = b, this.vertex2 = c, this.minX = Math.min(this.vertex1.x, this.vertex2.x), this.maxX = Math.max(this.vertex1.x, this.vertex2.x)
    }, g.prototype.containsPoint = function(a) {
        return f(this.vertex1, this.vertex2, a)
    }, g.prototype.overlapsYRange = function(a, b) {
        var c = this.vertex1.y,
            d = this.vertex2.y;
        return b >= Math.min(c, d) && a <= Math.max(c, d)
    }, g.prototype.isWithinYRange = function(a, b) {
        var c = this.vertex1.y,
            d = this.vertex2.y;
        return a <= Math.min(c, d) && b >= Math.max(c, d)
    }, g.prototype.inwardNormal = function() {
        var a = this.vertex2.x - this.vertex1.x,
            b = this.vertex2.y - this.vertex1.y,
            c = Math.sqrt(a * a + b * b);
        return {
            x: -b / c,
            y: a / c
        }
    }, g.prototype.outwardNormal = function() {
        var a = this.inwardNormal();
        return {
            x: -a.x,
            y: -a.y
        }
    }, g.prototype.xIntercept = function(a) {
        var b = this.vertex1.y,
            c = this.vertex2.y;
        return b == c ? Math.min(this.vertex1.x, this.vertex2.x) : a == Math.min(b, c) ? c > b ? this.vertex1.x : this.vertex2.x : a == Math.max(b, c) ? b > c ? this.vertex1.x : this.vertex2.x : this.vertex1.x + (a - b) * (this.vertex2.x - this.vertex1.x) / (c - b)
    }, g.prototype.clippedEdgeXRange = function(a, b) {
        if (this.isWithinYRange(a, b)) {
            var c = this.vertex1.x,
                d = this.vertex2.x;
            return {
                x1: Math.min(c, d),
                x2: Math.max(c, d)
            }
        }
        var e, f;
        this.vertex1.y < this.vertex2.y ? (e = this.vertex1, f = this.vertex2) : (e = this.vertex2, f = this.vertex1);
        var g = e.y < a ? this.xIntercept(a) : e.x,
            h = f.y > b ? this.xIntercept(b) : f.x;
        return {
            x1: Math.min(g, h),
            x2: Math.max(g, h)
        }
    }, i.prototype = new g, j.prototype = new g, l.prototype.vertexAt = function(a) {
        return this.m_vertices[a]
    }, l.prototype.edgeAt = function(a) {
        return this.m_edges[a]
    }, l.prototype.isEmpty = function() {
        return this.m_edges.length < 3 || this.bounds.isEmpty()
    }, l.prototype.vertices = function() {
        return this.m_vertices.slice(0)
    }, l.prototype.edges = function() {
        return this.m_edges.slice(0)
    }, l.prototype.overlapsYRange = function(a, b) {
        return a < this.bounds.maxY && b >= this.bounds.y
    }, l.prototype.nextVertexIndex = function(a, b) {
        var c = this.m_vertices.length;
        return (b ? a + 1 : a - 1 + c) % c
    }, l.prototype.nextEdgeVertexIndex = function(a, b) {
        for (var c = (this.m_vertices.length, this.nextVertexIndex(a, b)); c && e(this.vertexAt(a), this.vertexAt(c));) c = this.nextVertexIndex(c, b);
        for (; c;) {
            var f = this.nextVertexIndex(c, b);
            if (!d(this.vertexAt(a), this.vertexAt(c), this.vertexAt(f))) break;
            c = f
        }
        return c
    }, l.prototype.containsPointEvenOdd = function(a) {
        for (var b = 0, c = 0; c < this.m_edges.length; ++c) {
            var d = this.edgeAt(c);
            if (d.containsPoint(a)) return !0;
            var e = d.vertex1,
                f = d.vertex2;
            if (e.y <= a.y && f.y > a.y || e.y > a.y && f.y <= a.y) {
                var g = (a.y - e.y) / (f.y - e.y);
                a.x < e.x + g * (f.x - e.x) && ++b
            }
        }
        return 0 !== (1 & b)
    }, l.prototype.containsPointNonZero = function(a) {
        for (var b = 0, d = 0; d < this.m_edges.length; ++d) {
            var e = this.edgeAt(d);
            if (e.containsPoint(a)) return !0;
            var f = e.vertex1,
                g = e.vertex2;
            g.y < a.y ? f.y > a.y && c(f, g, a) > 0 && ++b : g.y > a.y && f.y <= a.y && c(f, g, a) < 0 && --b
        }
        return 0 !== b
    }, l.prototype.containsPoint = function(a) {
        return this.bounds.containsPoint(a) ? "nonzero" == this.fillRule ? this.containsPointNonZero(a) : this.containsPointEvenOdd(a) : !1
    }, l.prototype.edgeVerticesThatOverlapYRange = function(a, b) {
        for (var c = [], d = 0; d < this.m_edges.length; d++) {
            var e = this.edgeAt(d).vertex1;
            e.y >= a && e.y < b && c.push(e)
        }
        return c
    }, l.prototype.edgesThatOverlapYRange = function(a, b) {
        for (var c = [], d = 0; d < this.m_edges.length; d++) {
            var e = this.edgeAt(d);
            e.overlapsYRange(a, b) && c.push(e)
        }
        return c
    }, l.prototype.shapeMarginEdgesThatOverlapYRange = function(a, b) {
        for (var c = [], d = 0; d < this.shapeMarginEdges.length; d++) {
            var e = this.shapeMarginEdges[d];
            e.overlapsYRange(a, b) && c.push(e)
        }
        return c
    }, l.prototype.leftExclusionEdge = function(a, b) {
        if (this.isEmpty() || !this.bounds.overlapsYRange(a, b)) return void 0;
        var c, d, e, f = this.shapeMarginEdgesThatOverlapYRange(a, b);
        if (0 !== f.length)
            for (f.sort(m), c = f[0].clippedEdgeXRange(a, b).x1, d = 1; d < f.length && !(f[d].minX > c); d++) e = f[d].clippedEdgeXRange(a, b), c = void 0 === c ? e.x1 : Math.min(c, e.x1);
        var g = this.shapeMargin;
        if (g > 0) {
            var i = this.edgeVerticesThatOverlapYRange(a - g, b + g);
            for (i.sort(n), d = 0; d < i.length; d++) e = h(i[d], g, a, b), c = void 0 === c ? e.x1 : Math.min(c, e.x1)
        }
        return void 0 === c && console.error("Polygon leftExclusionEdge() failed"), c
    }, l.prototype.rightExclusionEdge = function(a, b) {
        if (this.isEmpty() || !this.bounds.overlapsYRange(a, b)) return void 0;
        var c, d, e, f = this.shapeMarginEdgesThatOverlapYRange(a, b);
        if (0 !== f.length)
            for (f.sort(o), c = f[0].clippedEdgeXRange(a, b).x2, d = 1; d < f.length && !(f[d].maxX < c); d++) e = f[d].clippedEdgeXRange(a, b), c = Math.max(c, e.x2);
        var g = this.shapeMargin;
        if (g > 0) {
            var i = this.edgeVerticesThatOverlapYRange(a - g, b + g);
            for (i.sort(p), d = 0; d < i.length; d++) e = h(i[d], g, a, b), c = void 0 === c ? e.x2 : Math.max(c, e.x2)
        }
        return void 0 === c && console.error("Polygon rightExclusionEdge() failed"), c
    }, r.none = {}, r.prototype.intervalAt = function(a) {
        return this.intervals[a + this.yOffset]
    }, r.prototype.setIntervalAt = function(a, b) {
        this.intervals[a + this.yOffset] = b
    }, r.prototype.uniteIntervalAt = function(a, b) {
        var c = this.intervalAt(a);
        c === r.none ? this.setIntervalAt(a, b) : (c.startX = Math.min(c.startX, b.startX), c.endX = Math.max(c.endX, b.endX))
    }, r.prototype.intervalAtContains = function(a, b) {
        var c = this.intervalAt(a);
        return c == r.none ? !1 : c.startX <= b.startX && c.endX >= b.endX
    }, s.prototype.generateIntervalAt = function(a, b) {
        var c = Math.abs(a - b.y),
            d = c > this.shapeMargin ? 0 : this.xIntercepts[c];
        return new q(a, b.startX - d, b.endX + d)
    }, r.prototype.computeMarginIntervals = function(a) {
        for (var b = new s(a), c = new r(this.yOffset, this.size), d = this.minY; d < this.maxY; ++d) {
            var e = this.intervalAt(d);
            if (e != r.none) {
                var f, g = Math.max(this.minY, d - a),
                    h = Math.min(this.maxY - 1, d + a);
                for (f = d - 1; f >= g && !(f > 0 && this.intervalAtContains(f, e)); --f) c.uniteIntervalAt(f, b.generateIntervalAt(f, e));
                for (c.uniteIntervalAt(d, b.generateIntervalAt(d, e)), f = d + 1; h >= f && !(f < this.maxY && this.intervalAtContains(f, e)); ++f) c.uniteIntervalAt(f, b.generateIntervalAt(f, e))
            }
        }
        return c
    }, u.prototype.hasData = function() {
        return !!this.imageData
    }, u.prototype.alphaAt = function(a, b) {
        return this.imageData.data[4 * a + 3 + b * this.width * 4]
    }, v.prototype.init = function(a) {
        var b, c = this,
            d = new Image,
            e = document.createElement("canvas");
        if (e.getContext || (t(c.url), a()), d.onload = function() {
                c.intervals = c.computeIntervals(d), c.intervals && c.shapeMargin > 0 && (c.intervals = c.intervals.computeMarginIntervals(c.shapeMargin, c.clip)), b && URL.revokeObjectURL(b), a()
            }, d.onerror = function() {
                t(c.url), a()
            }, !d.hasOwnProperty("crossOrigin") && window.URL && window.URL.createObjectURL) {
            var f = new XMLHttpRequest;
            f.onreadystatechange = function() {
                4 === f.readyState && (200 === f.status ? (b = URL.createObjectURL(f.response), d.src = b) : (t(c.url), a()))
            }, f.open("GET", c.url, !0), f.responseType = "blob", f.send()
        } else d.crossOrigin = "anonymous", d.src = c.url
    }, v.prototype.computeIntervals = function(a) {
        var b = this.clip,
            c = this.shapeImageThreshold,
            d = this.box.width,
            e = this.box.height,
            f = new u(a, d, e);
        if (!f.hasData()) return void 0;
        for (var g = new r(-b.y, b.height), h = Math.min(b.height, this.box.height), i = 0; h > i; i++)
            for (var j = -1, k = 0; k < this.box.width; k++) {
                var l = f.alphaAt(k, i); - 1 == j && l > c ? (j = k, g.intervalAt(i) === r.none && g.setIntervalAt(i, new q(i, j, d))) : -1 != j && c >= l && (g.intervalAt(i).endX = k, j = -1)
            }
        return g
    }, v.prototype.rightExclusionEdge = function(a, b) {
        var c = this.intervals;
        if (!c) return this.clip.width;
        for (var d, e = Math.max(a, this.clip.y); b >= e && e < this.clip.maxY; e++) {
            var f = c.intervalAt(e).endX;
            (void 0 === d || void 0 !== f && f > d) && (d = f)
        }
        return d
    }, v.prototype.leftExclusionEdge = function(a, b) {
        var c = this.intervals;
        if (!c) return 0;
        for (var d, e = Math.max(a, this.clip.y); b >= e && e < this.clip.maxY; e++) {
            var f = c.intervalAt(e).startX;
            (void 0 === d || void 0 !== f && d > f) && (d = f)
        }
        return d
    }, w.zeroSize = {
        width: 0,
        height: 0
    }, w.prototype.isEmpty = function() {
        return this.width <= 0 || this.height <= 0
    }, w.prototype.scale = function(a) {
        this.width *= a, this.height *= a
    }, x.prototype.isEmpty = function() {
        return this.width <= 0 || this.height <= 0
    }, x.prototype.containsX = function(a) {
        return a >= this.x && a < this.maxX
    }, x.prototype.containsY = function(a) {
        return a >= this.y && a < this.maxY
    }, x.prototype.containsPoint = function(a) {
        return this.containsX(a.x) && this.containsY(a.y)
    }, x.prototype.shiftLeftEdgeTo = function(a) {
        this.width -= a - this.x, this.x = a
    }, x.prototype.shiftTopEdgeTo = function(a) {
        this.height -= a - this.y, this.y = a
    }, x.prototype.shiftRightEdgeTo = function(a) {
        this.width = a - this.x
    }, x.prototype.shiftBottomEdgeTo = function(a) {
        this.height = a - this.y
    }, x.prototype.overlapsYRange = function(a, b) {
        return !this.isEmpty() && b >= this.y && a < this.maxY
    }, x.prototype.overlapsXRange = function(a, b) {
        return !this.isEmpty() && b >= this.x && a < this.maxX
    }, y.prototype.isEmpty = function() {
        return this.width <= 0 || this.height <= 0
    }, y.prototype.topLeftCorner = function() {
        return new x(this.rect.x, this.rect.y, this.radii.topLeft.width, this.radii.topLeft.height)
    }, y.prototype.topRightCorner = function() {
        return new x(this.rect.maxX - this.radii.topRight.width, this.rect.y, this.radii.topRight.width, this.radii.topRight.height)
    }, y.prototype.bottomLeftCorner = function() {
        return new x(this.rect.x, this.rect.maxY - this.radii.bottomLeft.height, this.radii.bottomLeft.width, this.radii.bottomLeft.height)
    }, y.prototype.bottomRightCorner = function() {
        return new x(this.rect.maxX - this.radii.bottomRight.width, this.rect.maxY - this.radii.bottomRight.height, this.radii.bottomRight.width, this.radii.bottomRight.height)
    }, y.prototype.isRounded = function() {
        function a(a) {
            return a.width > 0 && a.height > 0
        }
        return a(this.radii.topLeft) || a(this.radii.topRight) || a(this.radii.bottomLeft) || a(this.radii.bottomRight)
    }, y.prototype.cornersInsetRect = function() {
        var a = this.topLeftCorner(),
            b = this.topRightCorner(),
            c = this.bottomLeftCorner(),
            d = this.bottomRightCorner(),
            e = Math.max(a.maxX, c.maxX),
            f = Math.max(a.maxY, b.maxY);
        return new x(e, f, Math.min(b.x, d.x) - e, Math.min(c.y, d.y) - f)
    }, y.prototype.scaleRadii = function(a) {
        if (1 != a) {
            var b = this.radii;
            b.topLeft.scale(a), b.topLeft.isEmpty() && (b.topLeft = w.zeroSize), b.topRight.scale(a), b.topRight.isEmpty() && (b.topRight = w.zeroSize), b.bottomLeft.scale(a), b.bottomLeft.isEmpty() && (b.bottomLeft = w.zeroSize), b.bottomRight.scale(a), b.bottomRight.isEmpty() && (b.bottomRight = w.zeroSize)
        }
    }, y.prototype.isRenderable = function() {
        var a = this.radii,
            b = this.rect;
        return a.topLeft.width + a.topRight.width <= b.width && a.bottomLeft.width + a.bottomRight.width <= b.width && a.topLeft.height + a.bottomLeft.height <= b.height && a.topRight.height + a.bottomRight.height <= b.height
    }, y.prototype.adjustRadii = function() {
        var a = this.radii,
            b = Math.max(a.topLeft.width + a.topRight.width, a.bottomLeft.width + a.bottomRight.width),
            c = Math.max(a.topLeft.height + a.bottomLeft.height, a.topRight.height + a.bottomRight.height);
        if (0 >= b || 0 >= c) return void(this.radii = {
            topLeft: w.zeroSize,
            topRight: w.zeroSize,
            bottomRight: w.zeroSize,
            bottomLeft: w.zeroSize
        });
        var d = this.rect,
            e = d.width / b,
            f = d.height / c;
        this.scaleRadii(f > e ? e : f)
    }, y.prototype.minXInterceptAt = function(a, b) {
        if (!this.rect.containsY(a)) return b;
        var c, d = this.topLeftCorner();
        if (d.containsY(a)) return c = d.maxY - a, d.maxX - z(c, d.width, d.height);
        var e = this.bottomLeftCorner();
        return e.containsY(a) ? (c = a - e.y, e.maxX - z(c, e.width, e.height)) : this.rect.x
    }, y.prototype.maxXInterceptAt = function(a, b) {
        if (!this.rect.containsY(a)) return b;
        var c, d = this.topRightCorner();
        if (d.containsY(a)) return c = d.maxY - a, d.x + z(c, d.width, d.height);
        var e = this.bottomRightCorner();
        return e.containsY(a) ? (c = a - e.y, e.x + z(c, e.width, e.height)) : this.rect.maxX
    }, y.prototype.rightExclusionEdge = function(a, b) {
        return this.rect.isEmpty() || !this.rect.overlapsYRange(a, b) ? void 0 : !this.isRounded() || this.cornersInsetRect().overlapsYRange(a, b) ? this.rect.maxX : Math.max(this.maxXInterceptAt(a, this.rect.x), this.maxXInterceptAt(b, this.rect.x))
    }, y.prototype.leftExclusionEdge = function(a, b) {
        return this.rect.isEmpty() || !this.rect.overlapsYRange(a, b) ? void 0 : !this.isRounded() || this.cornersInsetRect().overlapsYRange(a, b) ? this.rect.x : Math.min(this.minXInterceptAt(a, this.rect.maxX), this.minXInterceptAt(b, this.rect.maxX))
    }, y.prototype.rightExclusionOffsets = F(y.prototype.topRightCorner, y.prototype.bottomRightCorner, E, C), y.prototype.leftExclusionOffsets = F(y.prototype.topLeftCorner, y.prototype.bottomLeftCorner, D, B), N.prototype.onReady = function(a) {
        this.ready ? a() : this.callback = a
    }, N.prototype.leftExclusionEdge = function(a) {
        return this.geometry ? this.geometry.leftExclusionEdge(a.top, a.bottom) : a.left
    }, N.prototype.rightExclusionEdge = function(a) {
        return this.geometry ? this.geometry.rightExclusionEdge(a.top, a.bottom) : a.right
    }, N.prototype.computeStepOffsets = function(a) {
        for (var b, c = [], d = 0; d < Math.ceil(this.metrics.marginBox.height / a); d++) {
            var e = {
                left: 0,
                right: this.shapeValue.box.width,
                top: d * a,
                bottom: Math.min((d + 1) * a, this.metrics.marginBox.height)
            };
            e.top -= this.metrics.margins[0] + this.shapeValue.box.y, e.bottom -= this.metrics.margins[0] + this.shapeValue.box.y, "left" === this.metrics.cssFloat ? (b = this.rightExclusionEdge(e), b = void 0 === b ? 0 : b + this.shapeValue.box.x + this.metrics.margins[3]) : (b = this.leftExclusionEdge(e), b = void 0 === b ? 0 : this.metrics.marginBox.width - (b + this.shapeValue.box.x + this.metrics.margins[3])), c.push({
                cssFloat: this.metrics.cssFloat,
                top: e.top + this.shapeValue.box.y + this.metrics.margins[0],
                bottom: e.bottom + this.shapeValue.box.y + this.metrics.margins[0],
                offset: Math.min(b, this.metrics.marginBox.width)
            })
        }
        return c
    }, N.prototype.computeAdaptiveOffsets = function(a) {
        for (var b = this.shapeValue.box.x + this.metrics.margins[3], c = this.metrics.margins[0] + this.shapeValue.box.y, d = "left" === this.metrics.cssFloat ? this.geometry.rightExclusionOffsets(-c, this.metrics.marginBox.height - c, a) : this.geometry.leftExclusionOffsets(-c, this.metrics.marginBox.height - c, a), e = [], f = 0, g = 0; g < d.length; g++) {
            var h;
            void 0 === d[g].x ? h = 0 : (h = "left" == this.metrics.cssFloat ? d[g].x + b : this.metrics.marginBox.width - (d[g].x + b), h = Math.min(h, this.metrics.marginBox.width)), e.push({
                offset: h,
                top: f,
                bottom: f + d[g].height,
                cssFloat: this.metrics.cssFloat
            }), f += d[g].height
        }
        return e
    }, N.prototype.offsets = function(a) {
        return this.geometry instanceof y ? "step" == (a && a.mode) ? this.computeStepOffsets(a.step) : this.computeAdaptiveOffsets(a.limit) : this.computeStepOffsets(a.step)
    }, O.prototype.polyfill = function(a, b) {
        var c = getComputedStyle(a);
        if (/left|right/.test(c.cssFloat) && a.getAttribute("data-shape-outside")) {
            var d = b && b.step || parseInt(c.fontSize),
                e = b && b.mode || "adaptive",
                f = b && b.limit || 1.8 * d,
                g = new N(a),
                h = this;
            g.onReady(function() {
                var c = g.offsets({
                    mode: e,
                    limit: f,
                    step: d
                });
                P(a, c), b && b.callback && "function" == typeof b.callback && b.callback.call(h.scope)
            })
        }
    }, O.prototype.removePolyfill = function(a) {
        var b = a.parentNode;
        for (b = a.parentNode; b && b.hasAttribute && !b.hasAttribute("data-shape-outside-container"); b = b.parentNode);
        b && b.hasAttribute && (b.parentNode.insertBefore(a, b), b.parentNode.removeChild(b))
    }, O.prototype.run = function(a) {
        var b = this,
            c = a && a.force,
            d = (c && (c === this.Force.Layout || c === this.Force.LayoutStyles), c && (c === this.Force.Styles || c === this.Force.LayoutStyles));
        if (c === this.Force.LayoutStyles ? a.force = this.Force.Layout : c && delete a.force, void 0 === this.hasNativeSupport) {
            var e = document.createElement("div"),
                f = ["shape-outside", "-webkit-shape-outside"];
            f.forEach(function(a) {
                e.style.setProperty(a, "content-box"), b.hasNativeSupport = b.hasNativeSupport || e.style.getPropertyValue(a)
            })
        }
        if (!this.hasNativeSupport || c) {
            if (!this.stylesLoaded || d) {
                this.stylesLoaded = !0, new _(function(c) {
                    c.forEach(function(a) {
                        for (var b = document.querySelectorAll(a.selector), c = 0; c < b.length; c++) b[c].setAttribute("data-" + a.property, a.value)
                    }), b.run(a)
                });
                var g = Q(function() {
                    b.teardown(), b.run(a)
                }, 300);
                return void this.scope.addEventListener("resize", g)
            }
            for (var h = document.querySelectorAll("[data-shape-outside]"), i = 0; i < h.length; i++) this.polyfill(h[i], a)
        }
    }, O.prototype.teardown = function() {
        for (var a = document.querySelectorAll("[data-shape-outside]"), b = 0; b < a.length; b++) this.removePolyfill(a[b])
    }, O.prototype.Force = {
        Layout: "force-layout",
        Styles: "force-styles",
        LayoutStyles: "force-layout-styles"
    }, Object.freeze && (O.prototype.Force = Object.freeze(O.prototype.Force)), R.prototype.parseUrl = function(a) {
        var b = /url\((.*)\)/.exec(a);
        return b ? (b = b[1], b = b.replace(/^['"]/, ""), b = b.replace(/['"]$/, "")) : null
    }, R.prototype.parseBox = function(a, b) {
        var c = /margin-box|border-box|padding-box|content-box/.exec(a);
        c = c ? c[0] : "margin-box";
        var d = JSON.parse(JSON.stringify(b.borderBox.radii)),
            e = {
                text: c,
                x: b.borderBox.x,
                y: b.borderBox.y,
                width: b.borderBox.width,
                height: b.borderBox.height,
                radii: d
            };
        switch (c) {
            case "content-box":
                S(e, -1, [b.paddings, b.borders]), U(e.radii, -1, [b.paddings, b.borders]);
                break;
            case "padding-box":
                S(e, -1, [b.borders]), U(e.radii, -1, [b.borders]);
                break;
            case "border-box":
                break;
            case "margin-box":
                S(e, 1, [b.margins]), U(e.radii, 1, [b.margins])
        }
        return e
    }, R.prototype.printShape = function() {
        if (this.shape) switch (this.shape.type) {
            case "inset":
                return "inset(" + this.shape.insets.join(" ") + " round " + V(this.shape.radii, 0).join(" ") + " / " + V(this.shape.radii, 1).join(" ") + ")";
            case "circle":
                return "circle(" + this.shape.r + " at " + this.shape.cx + " " + this.shape.cy + ")";
            case "ellipse":
                return "ellipse(" + this.shape.rx + " " + this.shape.ry + " at " + this.shape.cx + " " + this.shape.cy + ")";
            case "polygon":
                return "polygon(" + this.shape.fillRule + ", " + this.shape.points.map(function(a) {
                    return a.x + " " + a.y
                }).join(", ") + ")";
            default:
                return "not yet implemented for " + this.shape.type
        }
        return "no shape specified"
    }, R.prototype.printBox = function() {
        return this.box ? this.box.text + " { x: " + this.box.x + ", y: " + this.box.y + ", width: " + this.box.width + ", height: " + this.box.height + ", radii: " + V(this.box.radii, 0).join(" ") + " / " + V(this.box.radii, 1).join(" ") + " }" : "no box specified"
    }, R.prototype.parseBasicShape = function(a, b, c) {
        var d = /(inset|circle|ellipse|polygon)\((.*)\)/.exec(a);
        if (!d) return null;
        var e = d[1],
            f = d[2] ? d[2] : "";
        switch (e) {
            case "inset":
                return this.parseInset(f, b, c);
            case "circle":
                return this.parseCircle(f, b, c);
            case "ellipse":
                return this.parseEllipse(f, b, c);
            case "polygon":
                return this.parsePolygon(f, b, c);
            default:
                return null
        }
    }, R.prototype.parseInset = function(a, b, c) {
        var d = /((?:[^r]|r(?!o))*)?\s*(?:round\s+([^\/]*)(?:\s*\/\s*(.*))?)?/;
        a = d.exec(a);
        var e = {
            type: "inset",
            insets: [0, 0, 0, 0],
            radii: [
                [0, 0],
                [0, 0],
                [0, 0],
                [0, 0]
            ]
        };
        if (a && a[1]) {
            var f = a[1].trim();
            f = f.split(/\s+/), e.insets[0] = f[0], e.insets[1] = f.length > 1 ? f[1] : e.insets[0], e.insets[2] = f.length > 2 ? f[2] : e.insets[0], e.insets[3] = f.length > 3 ? f[3] : e.insets[1], e.insets[0] = c.toPixels(e.insets[0], b.height), e.insets[1] = c.toPixels(e.insets[1], b.width), e.insets[2] = c.toPixels(e.insets[2], b.height), e.insets[3] = c.toPixels(e.insets[3], b.width)
        }
        var g;
        return a && a[2] && (g = a[2].trim(), g = g.split(/\s+/), g.length < 2 && g.push(g[0]), g.length < 3 && g.push(g[0]), g.length < 4 && g.push(g[1]), e.radii = g.map(function(a) {
            return a = c.toPixels(a, b.width), [a, a]
        })), a && a[3] && (g = a[3].trim(), g = g.split(/\s+/), g.length < 2 && g.push(g[0]), g.length < 3 && g.push(g[0]), g.length < 4 && g.push(g[1]), g.forEach(function(a, d) {
            e.radii[d][1] = c.toPixels(a, b.height)
        })), e.x = e.insets[3], e.y = e.insets[0], e.width = b.width - (e.insets[1] + e.insets[3]), e.height = b.height - (e.insets[0] + e.insets[2]), e
    }, R.prototype.parseEllipsoid = function(a) {
        var b = /((?:[^a]|a(?!t))*)?\s*(?:at\s+(.*))?/;
        a = b.exec(a);
        var c = {};
        if (a && a[1]) {
            var d = a[1].trim();
            d = d.split(/\s+/), c.rx = d[0], c.ry = d.length > 1 ? d[1] : d[0]
        } else c.rx = c.ry = "closest-side";
        var e = [];
        if (a && a[2]) {
            var f = a[2].trim();
            f = f.split(/\s+/);
            var g = !1;
            f.forEach(function(a) {
                /\d+/.test(a) && g ? e[e.length - 1] += " " + a : e.push(a), g = /top|bottom|left|right/.test(a) && f.length > 2
            })
        }
        for (; e.length < 2;) e.push("center");
        if (/top|bottom/.test(e[0]) || /left|right/.test(e[1])) {
            var h = e[0];
            e[0] = e[1], e[1] = h
        }
        return c.cx = e[0], c.cy = e[1], c
    }, R.prototype.parseCircle = function(a, b, c) {
        var d = this.parseEllipsoid(a);
        return d.type = "circle", d.cx = W(d.cx, b.width, c), d.cy = W(d.cy, b.height, c), d.r = X(d.rx, [Math.abs(d.cx), Math.abs(b.width - d.cx), Math.abs(d.cy), Math.abs(b.height - d.cy)], Math.sqrt((b.width * b.width + b.height * b.height) / 2), c), delete d.rx, delete d.ry, d
    }, R.prototype.parseEllipse = function(a, b, c) {
        var d = this.parseEllipsoid(a);
        return d.type = "ellipse", d.cx = W(d.cx, b.width, c), d.cy = W(d.cy, b.height, c), d.rx = X(d.rx, [Math.abs(d.cx), Math.abs(b.width - d.cx)], b.width, c), d.ry = X(d.ry, [Math.abs(d.cy), Math.abs(b.height - d.cy)], b.height, c), d
    }, R.prototype.parsePolygon = function(a, b, c) {
        a = a.split(/\s*,\s*/);
        var d = "nonzero";
        a.length > 0 && /nonzero|evenodd/.test(a[0]) && (d = a[0].trim(), a = a.slice(1));
        var e = a.map(function(a) {
            var d = a.split(/\s+/);
            return {
                x: c.toPixels(d[0], b.width),
                y: c.toPixels(d[1], b.height)
            }
        });
        return {
            type: "polygon",
            fillRule: d,
            points: e
        }
    }, R.prototype.computeClip = function(a, b) {
        var c = b.margins[3],
            d = b.margins[0],
            e = b.margins[3] + b.margins[1],
            f = b.margins[0] + b.margins[2];
        return {
            x: -a.x - c,
            y: -a.y - d,
            width: b.borderBox.width + e,
            height: b.borderBox.height + f
        }
    }, R.prototype.parseShapeMargin = function(a, b, c) {
        return parseInt(a) ? Math.max(0, c.toPixels(a, b.width)) : 0
    }, R.prototype.parseShapeImageThreshold = function(a) {
        var b = parseFloat(a);
        return b ? Math.min(Math.max(0, b), 1) : 0
    }, Z.prototype.load = function(a, b, c) {
        var d = this;
        if (this.url) {
            var e = new XMLHttpRequest;
            e.onreadystatechange = function() {
                4 === e.readyState && (200 === e.status ? (d.cssText = e.responseText, a.call(c, d)) : b.call(c, d))
            }, e.open("GET", this.url);
            try {
                e.send(null)
            } catch (f) {
                console.log("An error occurred loading a stylesheet, probably because we can't access the local file system"), b.call(c, d)
            }
        } else this.cssText = this.source.textContent, a.call(c, d)
    }, $.prototype.init = function() {
        var a, b, c = Y(),
            d = c.length;
        for (this.queueCount = d, b = 0; d > b; b++) a = new Z(c[b]), this.stylesheets.push(a), a.load(this.onStyleSheetLoad, this.onStyleSheetError, this)
    }, $.prototype.onStyleSheetLoad = function() {
        this.queueCount--, this.onComplete.call(this)
    }, $.prototype.onStyleSheetError = function(a) {
        var b, c = this.stylesheets.length;
        for (b = 0; c > b; b++)
            if (a.source === this.stylesheets[b].source) return this.stylesheets.splice(b, 1), this.queueCount--, void this.onComplete.call(this)
    }, $.prototype.onComplete = function() {
        0 === this.queueCount && this.callback.call(this, this.stylesheets)
    }, _.prototype.onStylesLoaded = function(a) {
        var b, c, d = "\\s*([^{}]*[^\\s])\\s*{[^\\}]*",
            e = "\\s*:\\s*((?:[^;\\(]|\\([^\\)]*\\))*)\\s*;",
            f = [],
            g = ["shape-outside", "shape-margin", "shape-image-threshold"];
        g.forEach(function(g) {
            b = new RegExp(d + "(" + g + ")" + e, "ig"), a.forEach(function(a) {
                for (; null !== (c = b.exec(a.cssText));) f.push({
                    selector: c[1],
                    property: c[2],
                    value: c[3]
                })
            })
        }), this.callback(f)
    }, a.ShapesPolyfill = new O(a)
}(window);